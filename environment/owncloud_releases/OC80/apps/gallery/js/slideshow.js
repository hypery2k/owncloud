/**
 *
 * @param {jQuery} container
 * @param {{name:string, url: string, path: string, fallBack: string}[]} images
 * @param {int} interval
 * @param {int} maxScale
 * @constructor
 */
var SlideShow = function (container, images, interval, maxScale) {
	this.container = container;
	this.images = images;
	this.interval = interval | 5000;
	this.maxScale = maxScale | 2;
	this.playTimeout = 0;
	this.current = 0;
	this.imageCache = {};
	this.playing = false;
	this.progressBar = container.find('.progress');
	this.currentImage = null;
	this.onStop = null;
	this.active = false;
};

SlideShow.prototype.init = function (play) {
	this.active = true;
	this.container.children('img').remove();

	// hide arrows and play/pause when only one pic
	this.container.find('.next, .previous').toggle(this.images.length > 1);
	if (this.images.length === 1) {
		this.container.find('.play, .pause').hide();
	}

	var makeCallBack = function (handler) {
		return function (evt) {
			if (!this.active) {
				return;
			}
			evt.stopPropagation();
			handler.call(this);
		}.bind(this);
	}.bind(this);

	this.container.children('.next').click(makeCallBack(this.next));
	this.container.children('.previous').click(makeCallBack(this.previous));
	this.container.children('.exit').click(makeCallBack(this.stop));
	this.container.children('.pause').click(makeCallBack(this.pause));
	this.container.children('.play').click(makeCallBack(this.play));
	this.container.click(makeCallBack(this.next));


	$(document).keyup(function (evt) {
		if (evt.keyCode === 27) { // esc
			makeCallBack(this.stop)(evt);
		} else if (evt.keyCode === 37) { // left
			makeCallBack(this.previous)(evt);
		} else if (evt.keyCode === 39) { // right
			makeCallBack(this.next)(evt);
		} else if (evt.keyCode === 32) { // space
			makeCallBack(this.play)(evt);
		}
	}.bind(this));

	if ($.fn.mousewheel) {
		this.container.bind('mousewheel.fb', function (e, delta) {
			e.preventDefault();
			if ($(e.target).get(0).clientHeight === 0 ||
				$(e.target).get(0).scrollHeight === $(e.target).get(0).clientHeight) {
				if (delta > 0) {
					this.previous();
				} else {
					this.next();
				}
			}
		}.bind(this));
	}

	jQuery(window).resize(function () {
		this.fitImage(this.currentImage.bind(this));
	}.bind(this));

	if (play) {
		this.play();
	} else {
		this.pause();
	}
};

SlideShow.prototype.onKeyUp = function () {

};

SlideShow.prototype.show = function (index) {
	this.container.show();
	this.current = index;
	this.container.css('background-position', 'center');
	return this.loadImage(this.images[index].url, this.images[index].fallBack).then(function (image) {
		this.container.css('background-position', '-10000px 0');

		// check if we moved along while we were loading
		if (this.current === index) {
			this.currentImage = image;
			this.container.children('img').remove();
			this.container.append(image);
			image.setAttribute('alt', this.images[index].name);
			this.fitImage(image);
			this.setUrl(this.images[index].path);
			if (this.playing) {
				this.setTimeout();
			}
		}
	}.bind(this));
};

SlideShow.prototype.setUrl = function (path) {
	if (history && history.replaceState) {
		history.replaceState('', '', '#' + encodeURI(path));
	}
};

SlideShow.prototype.loadImage = function (url, fallBack) {
	if (!this.imageCache[url]) {
		this.imageCache[url] = new jQuery.Deferred();
		var image = new Image();

		image.onload = function () {
			if (image) {
				image.natWidth = image.width;
				image.natHeight = image.height;
			}
			if (this.imageCache[url]) {
				this.imageCache[url].resolve(image);
			}
		}.bind(this);
		image.onerror = function () {
			if (fallBack) {
				this.loadImage(fallBack).then(function (image) {
					this.imageCache[url].resolve(image);
				}.bind(this), function (url) {
					this.imageCache[url].reject(url);
				}.bind(this));
			} else if (this.imageCache[url]) {
				this.imageCache[url].reject(url);
			}
		}.bind(this);
		image.src = url;
	}
	return this.imageCache[url];
};

SlideShow.prototype.fitImage = function (image) {
	if (!image) {
		return;
	}
	var ratio = image.natWidth / image.natHeight,
		screenRatio = this.container.width() / this.container.height(),
		width = null, height = null, top = null;
	if (ratio > screenRatio) {
		if (this.container.width() > image.natWidth * this.maxScale) {
			top = ((this.container.height() - image.natHeight) / 2) + 'px';
			height = image.natHeight + 'px';
			width = image.natWidth + 'px';
		} else {
			width = this.container.width() + 'px';
			height = (this.container.width() / ratio) + 'px';
			top = ((this.container.height() - (this.container.width() / ratio)) / 2) + 'px';
		}
	} else {
		if (this.container.height() > image.natHeight * this.maxScale) {
			top = ((this.container.height() - image.natHeight) / 2) + 'px';
			height = image.natHeight + 'px';
			width = image.natWidth + 'px';
		} else {
			top = 0;
			height = this.container.height() + 'px';
			width = (this.container.height() * ratio) + "px";
		}
	}
	jQuery(image).css({
		top: top,
		width: width,
		height: height
	});
};

SlideShow.prototype.setTimeout = function () {
	this.clearTimeout();
	this.playTimeout = setTimeout(this.next.bind(this), this.interval);
	this.progressBar.stop();
	this.progressBar.css('height', '6px');
	this.progressBar.animate({'height': '26px'}, this.interval, 'linear');
};

SlideShow.prototype.clearTimeout = function () {
	if (this.playTimeout) {
		clearTimeout(this.playTimeout);
	}
	this.progressBar.stop();
	this.progressBar.css('height', '6px');
	this.playTimeout = 0;
};

SlideShow.prototype.play = function () {
	this.playing = true;
	this.container.find('.pause').show();
	this.container.find('.play').hide();
	this.setTimeout();
};

SlideShow.prototype.pause = function () {
	this.playing = false;
	this.container.find('.pause').hide();
	this.container.find('.play').show();
	this.clearTimeout();
};

SlideShow.prototype.next = function () {
	this.current = (this.current + 1) % this.images.length;
	var next = (this.current + 1) % this.images.length;
	this.show(this.current).then(function () {
		// preload the next image
		this.loadImage(this.images[next].url, this.images[next].fallBack);
	}.bind(this));
};

SlideShow.prototype.previous = function () {
	this.current = (this.current - 1 + this.images.length) % this.images.length;
	var previous = (this.current - 1 + this.images.length) % this.images.length;
	this.show(this.current).then(function () {
		// preload the next image
		this.loadImage(this.images[previous].url, this.images[previous].fallBack);
	}.bind(this));
};

SlideShow.prototype.stop = function () {
	this.clearTimeout();
	this.container.hide();
	this.active = false;
	if (this.onStop) {
		this.onStop();
	}
};

SlideShow.prototype.hideImage = function () {
	this.container.children('img').remove();
};

SlideShow.prototype.togglePlay = function () {
	if (this.playing) {
		this.pause();
	} else {
		this.play();
	}
};

SlideShow._getSlideshowTemplate = function () {
	var defer = $.Deferred();
	if (!this.$slideshowTemplate) {
		var self = this;
		$.get(OC.filePath('gallery', 'templates', 'slideshow.html'), function (tmpl) {
			var template = $(tmpl);
			template.find('.next').val(t('gallery', 'Next'));
			template.find('.play').val(t('gallery', 'Play'));
			template.find('.pause').val(t('gallery', 'Pause'));
			template.find('.previous').val(t('gallery', 'Previous'));
			template.find('.exit').val(t('gallery', 'Close'));
			self.$slideshowTemplate = template;
			defer.resolve(self.$slideshowTemplate);
		})
			.fail(function () {
				defer.reject();
			});
	} else {
		defer.resolve(this.$slideshowTemplate);
	}
	return defer.promise();
};

$(document).ready(function () {
	if ($('#body-login').length > 0) {
		return true; //deactivate slideshow on login page
	}

	$.when(SlideShow._getSlideshowTemplate()).then(function ($tmpl) {
		$('body').append($tmpl); //move the slideshow outside the content so we can hide the content

		var inactiveCallback = function () {
			$('#slideshow').addClass('inactive');
		};
		var inactiveTimeout = setTimeout(inactiveCallback, 3000);

		$('#slideshow').mousemove(function () {
			$('#slideshow').removeClass('inactive');
			clearTimeout(inactiveTimeout);
			inactiveTimeout = setTimeout(inactiveCallback, 3000);
		});

		//replace all svg images with png images for browser that dont support svg
		if (!OC.Util.hasSVGSupport()) {
			OC.Util.replaceSVG(this.$el);
		}
	})
		.fail(function () {
			OC.Notification.show(t('core', 'Error loading slideshow template'));
		});


	if (OCA.Files && OCA.Files.fileActions) {
		OCA.Files.fileActions.register('image', 'View', OC.PERMISSION_READ, '', function (filename, context) {
			var imageUrl, files = context.fileList.files;
			var start = 0;
			var images = [];
			var dir = context.dir + '/';
			var user = OC.currentUser;
			var width = $(document).width() * window.devicePixelRatio;
			var height = $(document).height() * window.devicePixelRatio;
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				if (file.mimetype && file.mimetype.indexOf('image') >= 0) {
					if (file.mimetype === 'image/svg+xml' || file.mimetype === 'image/gif') {
						imageUrl = OCA.Files.Files.getDownloadUrl(file.name, dir);
					} else {
						imageUrl = OC.generateUrl('/core/preview.png?file={file}&x={x}&y={y}&a=true&scalingup=0&forceIcon=0', {
							x: width,
							y: height,
							file: encodeURIComponent(dir + file.name)
						});
						if (!user) {
							imageUrl = OC.generateUrl(
								'/apps/files_sharing/publicpreview?file={file}&x={x}&y={y}&a=true&t={t}&scalingup=0&forceIcon=0', {
									file: encodeURIComponent(dir + file.name),
									x: width,
									y: height,
									t: $('#sharingToken').val()
								});
						}
					}

					images.push({
						name: file.name,
						path: dir + file.name,
						url: imageUrl,
						fallBack: OCA.Files.Files.getDownloadUrl(file.name, dir)
					});
				}
			}
			for (i = 0; i < images.length; i++) {
				if (images[i].name === filename) {
					start = i;
				}
			}
			var slideShow = new SlideShow($('#slideshow'), images);
			slideShow.init();
			slideShow.show(start);
		});
		OCA.Files.fileActions.setDefault('image', 'View');
	}
});
