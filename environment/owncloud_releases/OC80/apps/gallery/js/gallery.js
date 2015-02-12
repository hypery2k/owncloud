/* global Album, GalleryImage, SlideShow, Thumbnail, oc_requesttoken */
var Gallery = {};
Gallery.images = [];
Gallery.currentAlbum = '';
Gallery.users = [];
Gallery.albumMap = {};
Gallery.imageMap = {};

Gallery.getAlbum = function (path, token) {
	if (!Gallery.albumMap[path]) {
		Gallery.albumMap[path] = new Album(path, [], [], OC.basename(path), token);
		if (path !== '') {
			var parent = OC.dirname(path);
			if (parent === path) {
				parent = '';
			}
			Gallery.getAlbum(parent, token).subAlbums.push(Gallery.albumMap[path]);
		}
	}
	return Gallery.albumMap[path];
};

// fill the albums from Gallery.images
Gallery.fillAlbums = function () {
	var sortFunction = function (a, b) {
		return a.path.toLowerCase().localeCompare(b.path.toLowerCase());
	};
	var token = $('#gallery').data('token');
	var album, image;
	return $.getJSON(OC.generateUrl('apps/gallery/ajax/images'), {token: token}).then(function (data) {
		Gallery.images = data;

		var path = null;
		for (var i = 0; i < Gallery.images.length; i++) {
			path = Gallery.images[i];
			image = new GalleryImage(Gallery.images[i], path, token);
			var dir = OC.dirname(path);
			if (dir === path) {
				dir = '';
			}
			album = Gallery.getAlbum(dir, token);
			album.images.push(image);
			Gallery.imageMap[image.path] = image;
		}

		for (path in Gallery.albumMap) {
			Gallery.albumMap[path].images.sort(sortFunction);
			Gallery.albumMap[path].subAlbums.sort(sortFunction);
		}
	});
};

Gallery.getAlbumInfo = function (album) {
	if (album === $('#gallery').data('token')) {
		return [];
	}
	if (!Gallery.getAlbumInfo.cache[album]) {
		var def = new $.Deferred();
		Gallery.getAlbumInfo.cache[album] = def;
		$.getJSON(OC.generateUrl('apps/gallery/ajax/gallery?gallery={gallery}', {gallery: album}), function (data) {
			def.resolve(data);
		});
	}
	return Gallery.getAlbumInfo.cache[album];
};
Gallery.getAlbumInfo.cache = {};
Gallery.getImage = function (image) {
	var token = ($('#gallery').data('token')) ? $('#gallery').data('token') : '';
	return OC.generateUrl('apps/gallery/ajax/image?file={file}&token={token}', {
		file: encodeURIComponent(image),
		token: token
	});
};
Gallery.share = function (event) {
	if (!OC.Share.droppedDown) {
		event.preventDefault();
		event.stopPropagation();

		(function () {
			var target = OC.Share.showLink;
			OC.Share.showLink = function () {
				var r = target.apply(this, arguments);
				$('#linkText').val($('#linkText').val().replace('service=files', 'service=gallery'));
				return r;
			};
		})();

		Gallery.getAlbumInfo(Gallery.currentAlbum).then(function (info) {
			$('a.share').data('item', info.fileid).data('link', true)
				.data('possible-permissions', info.permissions).
				click();
			if (!$('#linkCheckbox').is(':checked')) {
				$('#linkText').hide();
			}
		});
	}
};
Gallery.view = {};
Gallery.view.element = null;
Gallery.view.clear = function () {
	Gallery.view.element.empty();
	Gallery.showLoading();
};
Gallery.view.cache = {};


Gallery.view.viewAlbum = function (albumPath) {
	var i, crumbs, path;
	albumPath = albumPath || '';
	if (!Gallery.albumMap[albumPath]) {
		return;
	}

	Gallery.view.clear();
	if (albumPath !== Gallery.currentAlbum) {
		Gallery.view.loadVisibleRows.loading = false;
	}
	Gallery.currentAlbum = albumPath;

	if (albumPath === '' || $('#gallery').data('token')) {
		$('button.share').hide();
	} else {
		$('button.share').show();
	}

	OC.Breadcrumb.clear();
	var albumName = $('#content').data('albumname');
	if (!albumName) {
		albumName = t('gallery', 'Pictures');
	}
	OC.Breadcrumb.push(albumName, '#').click(function () {
		Gallery.view.viewAlbum('');
	});
	path = '';
	crumbs = albumPath.split('/');
	for (i = 0; i < crumbs.length; i++) {
		if (crumbs[i]) {
			if (path) {
				path += '/' + crumbs[i];
			} else {
				path += crumbs[i];
			}
			Gallery.view.pushBreadCrumb(crumbs[i], path);
		}
	}

	Gallery.getAlbumInfo(Gallery.currentAlbum); //preload album info

	Gallery.albumMap[albumPath].viewedItems = 0;
	setTimeout(function () {
		Gallery.view.loadVisibleRows.activeIndex = 0;
		Gallery.view.loadVisibleRows(Gallery.albumMap[Gallery.currentAlbum], Gallery.currentAlbum);
	}, 0);
};

Gallery.view.loadVisibleRows = function (album, path) {
	if (Gallery.view.loadVisibleRows.loading && Gallery.view.loadVisibleRows.loading.state() !== 'resolved') {
		return Gallery.view.loadVisibleRows.loading;
	}
	// load 2 windows worth of rows
	var scroll = $('#content-wrapper').scrollTop() + $(window).scrollTop();
	var targetHeight = ($(window).height() * 2) + scroll;
	var showRows = function (album) {
		if (!(album.viewedItems < album.subAlbums.length + album.images.length)) {
			Gallery.view.loadVisibleRows.loading = null;
			return;
		}
		return album.getNextRow($(window).width()).then(function (row) {
			return row.getDom().then(function (dom) {
				// defer removal of loading class to trigger CSS3 animation
				_.defer(function () {
					dom.removeClass('loading');
				});
				if (Gallery.currentAlbum !== path) {
					Gallery.view.loadVisibleRows.loading = null;
					return; //throw away the row if the user has navigated away in the meantime
				}
				if (Gallery.view.element.length === 1) {
					Gallery.showNormal();
				}
				Gallery.view.element.append(dom);
				if (album.viewedItems < album.subAlbums.length + album.images.length &&
					Gallery.view.element.height() < targetHeight) {
					return showRows(album);
				} else {
					Gallery.view.loadVisibleRows.loading = null;
				}
			}, function () {
				Gallery.view.loadVisibleRows.loading = null;
			});
		});
	};
	if (Gallery.view.element.height() < targetHeight) {
		Gallery.view.loadVisibleRows.loading = true;
		Gallery.view.loadVisibleRows.loading = showRows(album);
		return Gallery.view.loadVisibleRows.loading;
	}
};
Gallery.view.loadVisibleRows.loading = false;

Gallery.view.pushBreadCrumb = function (text, path) {
	OC.Breadcrumb.push(text, '#' + path).click(function () {
		Gallery.view.viewAlbum(path);
	});
};

Gallery.showEmpty = function () {
	$('#controls').addClass('hidden');
	$('#emptycontent').removeClass('hidden');
	$('#content').removeClass('icon-loading');
};

Gallery.showLoading = function () {
	$('#emptycontent').addClass('hidden');
	$('#controls').removeClass('hidden');
	$('#content').addClass('icon-loading');
};

Gallery.showNormal = function () {
	$('#emptycontent').addClass('hidden');
	$('#controls').removeClass('hidden');
	$('#content').removeClass('icon-loading');
};

Gallery.slideShow = function (images, startImage, autoPlay) {
	var start = images.indexOf(startImage);

	images = images.map(function (image) {
		return {
			name: OC.basename(image.path),
			url: Gallery.getImage(image.src),
			path: image.path
		};
	});

	var slideShow = new SlideShow($('#slideshow'), images);
	Thumbnail.concurrent = 1;
	slideShow.onStop = function () {
		Gallery.activeSlideShow = null;
		$('#content').show();
		location.hash = encodeURI(Gallery.currentAlbum);
		Thumbnail.concurrent = 3;
	};
	Gallery.activeSlideShow = slideShow;

	slideShow.init(autoPlay);
	slideShow.show(start);
};

Gallery.activeSlideShow = null;

$(document).ready(function () {
	Gallery.showLoading();

	Gallery.view.element = $('#gallery');
	Gallery.fillAlbums().then(function () {
		if (Gallery.images.length === 0) {
			Gallery.showEmpty();
		}
		OC.Breadcrumb.container = $('#breadcrumbs');
		window.onhashchange();
		$('button.share').click(Gallery.share);
	});

	$('#openAsFileListButton').click(function () {
		window.location.href = OC.generateUrl('s/{token}', {
			token: $('#gallery').data('token')
		});
	});

	$(window).scroll(function () {
		Gallery.view.loadVisibleRows(Gallery.albumMap[Gallery.currentAlbum], Gallery.currentAlbum);
	});
	$('#content-wrapper').scroll(function () {
		Gallery.view.loadVisibleRows(Gallery.albumMap[Gallery.currentAlbum], Gallery.currentAlbum);
	});

	$(window).resize(_.throttle(function () {
		Gallery.view.viewAlbum(Gallery.currentAlbum);
	}, 500));

	if ($('#gallery').data('requesttoken')) {
		oc_requesttoken = $('#gallery').data('requesttoken');
	}
});

window.onhashchange = function () {
	var path = decodeURI(location.hash).substr(1);
	if (Gallery.albumMap[path]) {
		if (Gallery.activeSlideShow) {
			Gallery.activeSlideShow.stop();
		}
		path = decodeURIComponent(path);
		if (Gallery.currentAlbum !== path || path === '') {
			Gallery.view.viewAlbum(path);
		}
	} else if (!Gallery.activeSlideShow) {
		var albumPath = OC.dirname(path);
		if (albumPath === path) {
			albumPath = '';
		}
		if (Gallery.currentAlbum !== albumPath || albumPath === '') {
			Gallery.view.viewAlbum(albumPath);
		}
		var album = Gallery.albumMap[albumPath];
		var images = album.images;
		var startImage = Gallery.imageMap[path];
		Gallery.slideShow(images, startImage);
	}
};
