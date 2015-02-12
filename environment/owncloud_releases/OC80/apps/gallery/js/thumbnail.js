/* global Gallery */
function Thumbnail (path, square, token) {
	this.token = token;
	this.square = square;
	this.path = path;
	this.url = Thumbnail.getUrl(path, square, token);
	this.image = null;
	this.loadingDeferred = new $.Deferred();
	this.ratio = null;
}

Thumbnail.map = {};
Thumbnail.squareMap = {};
Thumbnail.height = 200;
Thumbnail.width = 400;

Thumbnail.get = function (path, square, token) {
	var map = (square) ? Thumbnail.squareMap : Thumbnail.map;
	if (!map[path]) {
		map[path] = new Thumbnail(path, square, token);
	}
	return map[path];
};

Thumbnail.getUrl = function (path, square, token) {
	if (path.substr(path.length - 4) === '.svg' || path.substr(path.length - 5) === '.svgz') {
		return Gallery.getImage(path);
	}
	return OC.generateUrl('apps/gallery/ajax/thumbnail?file={file}&scale={scale}&square={square}&token={token}', {
		file: encodeURIComponent(path),
		scale: window.devicePixelRatio,
		square: (square) ? 1 : 0,
		token: (token) ? token : ''
	});
};

Thumbnail.loadBatch = function (paths, square, token) {
	var map = (square) ? Thumbnail.squareMap : Thumbnail.map;
	paths = paths.filter(function (path) {
		return !map[path];
	});
	var thumbnails = {};
	if (paths.length) {
		paths.forEach(function (path) {
			var thumb = new Thumbnail(path, square, token);
			thumb.image = new Image();
			map[path] = thumbnails[path] = thumb;
		});

		var url = OC.generateUrl(
			'apps/gallery/ajax/thumbnail/batch?token={token}&image={images}&scale={scale}&square={square}', {
			images: paths.map(encodeURIComponent).join(';'),
			scale: window.devicePixelRatio,
			square: (square) ? 1 : 0,
			token: (token) ? token : ''
		});

		var eventSource = new OC.EventSource(url);
		eventSource.listen('preview', function (data) {
			var path = data.image;
			var extension = path.substr(path.length - 3);
			var thumb = thumbnails[path];
			thumb.image.onload = function () {
				Thumbnail.loadingCount--;
				thumb.image.ratio = thumb.image.width / thumb.image.height;
				thumb.image.originalWidth = 200 * thumb.image.ratio;
				thumb.loadingDeferred.resolve(thumb.image);
			};
			thumb.image.src = 'data:image/' + extension + ';base64,' + data.preview;
		});
	}
	return thumbnails;
};

Thumbnail.prototype.load = function () {
	var that = this;
	if (!this.image) {
		this.image = new Image();
		this.image.onload = function () {
			Thumbnail.loadingCount--;
			that.image.ratio = that.image.width / that.image.height;
			that.image.originalWidth = that.image.width / window.devicePixelRatio;
			that.loadingDeferred.resolve(that.image);
			Thumbnail.processQueue();
		};
		this.image.onerror = function () {
			Thumbnail.loadingCount--;
			that.loadingDeferred.reject(that.image);
			Thumbnail.processQueue();
		};
		Thumbnail.loadingCount++;
		this.image.src = this.url;
	}
	return this.loadingDeferred;
};

Thumbnail.queue = [];
Thumbnail.loadingCount = 0;
Thumbnail.concurrent = 3;
Thumbnail.paused = false;

Thumbnail.processQueue = function () {
	if (!Thumbnail.paused && Thumbnail.queue.length && Thumbnail.loadingCount < Thumbnail.concurrent) {
		var next = Thumbnail.queue.shift();
		next.load();
		Thumbnail.processQueue();
	}
};

Thumbnail.prototype.queue = function () {
	if (!this.image) {
		Thumbnail.queue.push(this);
	}
	Thumbnail.processQueue();
	return this.loadingDeferred;
};
