
Filters = {};
Filters.ActiveCanvas;
Filters.ctx;
Filters.CanvasWidth;
Filters.CanvasHeight 
Filters.tmpCanvas = document.createElement('canvas');
Filters.tmpCtx = Filters.tmpCanvas.getContext('2d');
Filters.InitialImageData;
Filters.isPen = false;
Filters.mousePressed = false;
Filters.lastX;
Filters.lastY;
/********************  Global Functions *********************************************/
Filters.init = function (canvas,ctx) {
    
    Filters.ActiveCanvas = canvas;
    Filters.ctx = ctx;
    Filters.CanvasWidth = canvas[0].width;
    Filters.CanvasHeight = canvas[0].height;
};
Filters.SetInitialImageData = function (pixels)
{
    Filters.InitialImageData = pixels;
}
Filters.getPixels = function () {
     return Filters.ctx.getImageData(0, 0, Filters.CanvasWidth, Filters.CanvasHeight);
};
Filters.createImageData = function (w, h) {
    return this.tmpCtx.createImageData(w, h);
};
Filters.convolute = function (pixels, weights, opaque) {
    var side = Math.round(Math.sqrt(weights.length));
    var halfSide = Math.floor(side / 2);

    var src = pixels.data;
    var sw = pixels.width;
    var sh = pixels.height;

    var w = sw;
    var h = sh;
    var output = Filters.createImageData(w, h);
    var dst = output.data;

    var alphaFac = opaque ? 1 : 0;

    for (var y = 0; y < h; y++) {
        for (var x = 0; x < w; x++) {
            var sy = y;
            var sx = x;
            var dstOff = (y * w + x) * 4;
            var r = 0, g = 0, b = 0, a = 0;
            for (var cy = 0; cy < side; cy++) {
                for (var cx = 0; cx < side; cx++) {
                    var scy = Math.min(sh - 1, Math.max(0, sy + cy - halfSide));
                    var scx = Math.min(sw - 1, Math.max(0, sx + cx - halfSide));
                    var srcOff = (scy * sw + scx) * 4;
                    var wt = weights[cy * side + cx];
                    r += src[srcOff] * wt;
                    g += src[srcOff + 1] * wt;
                    b += src[srcOff + 2] * wt;
                    a += src[srcOff + 3] * wt;
                }
            }
            dst[dstOff] = r;
            dst[dstOff + 1] = g;
            dst[dstOff + 2] = b;
            dst[dstOff + 3] = a + alphaFac * (255 - a);
        }
    }
    return output;
};
Filters.applyFilter = function (pixels) {
    Filters.ctx.putImageData(pixels, 0, 0);
}
Filters.SetFilter = function (canvas, ctx, FilterName, args) {
    Filters.isPen = false;
    canvas.css("cursor", "none");
    Filters.init(canvas, ctx);

    switch (FilterName)
    {
        case "desaturate": Filters.grayscale(); return;
        case "brightness": Filters.brightness(10); return;
        case "threshold": Filters.threshold(120); return;
        case "sharpen": Filters.sharpen(); return;
        case "blur": Filters.blur(); return;
        case "fliph": Filters.fliph(); return;
        case "flipv": Filters.flipv(); return;
        case "reset": Filters.restore(); return;
        case "custom": Filters.custom(args); return;

        default: return;
    }

};
/******************** End Global Functions *********************************************/

/********************  Filters *********************************************/
Filters.fliph = function () {
  var img = new Image();
    img.onload = function () {
        Filters.ctx.save();
        Filters.ctx.translate(Filters.CanvasWidth, 0);
        Filters.ctx.scale(-1, 1);
        Filters.ctx.drawImage(img, 0, 0);
        Filters.ctx.restore();
    }
    img.src = Filters.ctx.canvas.toDataURL();
};
Filters.Crop = function (c,ctx, imageObj, sourceX, sourceY, sourceWidth, sourceHeight) {
    var img = new Image();
    img.onload = function () {

        ctx.drawImage(img, sourceX, sourceY, sourceWidth, sourceHeight, 0, 0, c[0].width, c[0].height);
    }
    img.src = imageObj.src;
    
}
Filters.flipv = function () {

    var img = new Image();
    img.onload = function () {
        Filters.ctx.save();
        Filters.ctx.scale(1, -1);
        Filters.ctx.drawImage(img, 0, -img.height);
        Filters.ctx.restore();
    }
    img.src = Filters.ctx.canvas.toDataURL();

};
Filters.grayscale = function () {
    var imageData = Filters.getPixels();
    var data = imageData.data;
    for(var i = 0; i < data.length; i += 4) {
        var brightness = 0.34 * data[i] + 0.5 * data[i + 1] + 0.16 * data[i + 2];
        // red
        data[i] = brightness;
        // green
        data[i + 1] = brightness;
        // blue
        data[i + 2] = brightness;
    }
    // overwrite original image
    Filters.applyFilter(imageData);
}
Filters.brightness = function (level) {
    var imageData = Filters.getPixels();
    var data = imageData.data;
    for (var i = 0; i < data.length; i += 4) {
        data[i] += level;
        data[i + 1] += level;
        data[i + 2] += level;
    }

    Filters.applyFilter(imageData);
}
Filters.threshold = function (threshold_level)
{
    var imageData = Filters.getPixels();
    var d = imageData.data;
    for (var i = 0; i < d.length; i += 4) {
        var r = d[i];
        var g = d[i + 1];
        var b = d[i + 2];
        var v = (0.2126 * r + 0.7152 * g + 0.0722 * b >= threshold_level) ? 255 : 0;
        d[i] = d[i + 1] = d[i + 2] = v
    }

    Filters.applyFilter(imageData);
}
Filters.sharpen = function () {
    var imageData = Filters.getPixels();
    var weights = [0, -1, 0,
                  -1, 5, -1,
                   0, -1, 0];
    var outputdata = Filters.convolute(imageData, weights);
    Filters.applyFilter(outputdata);
};
Filters.blur = function () {
    var imageData = Filters.getPixels();
    var weights = [1/9, 1/9, 1/9,
                   1/9, 1/9, 1/9,
                   1/9, 1/9, 1/9]
    var outputdata = Filters.convolute(imageData, weights);
    Filters.applyFilter(outputdata);


};
Filters.custom = function (weights) {
    var imageData = Filters.getPixels();
    var outputdata = Filters.convolute(imageData, weights);
    Filters.applyFilter(outputdata);
}
Filters.restore = function () {
    Filters.applyFilter(Filters.InitialImageData);
};



Filters.Pen = function (c, ctx, color, linewidth) {
    c.css("cursor", "crosshair");
    Filters.isPen = true;

    c.mousedown(function (e) {
        if (!Filters.isPen) {
            e.stopPropagation();
            return false;
        }
        var x = e.pageX - $(this).offset().left;
        var y = e.pageY - $(this).offset().top;
        Filters.mousePressed = true;
        Filters.DrawWithPen(ctx, x, y, false, color, linewidth);
    });

    c.mousemove(function (e) {
        if (!Filters.isPen) {
            e.stopPropagation();
            return false;
        }
        if (Filters.mousePressed) {
            var x = e.pageX - $(this).offset().left;
            var y = e.pageY - $(this).offset().top;
            Filters.DrawWithPen(ctx,x, y, true, color, linewidth);
        }
    });

    c.mouseup(function (e) {
        Filters.mousePressed = false;
    });
    c.mouseleave(function (e) {
        Filters.mousePressed = false;
    });
}
Filters.DrawWithPen=function(ctx,x,y,isDown,color,linewidth)
{
    if (isDown) {
        ctx.beginPath();
        ctx.strokeStyle = color;
        ctx.lineWidth = linewidth;
        ctx.lineJoin = "round";
        ctx.moveTo(Filters.lastX, Filters.lastY);
        ctx.lineTo(x, y);
        ctx.closePath();
        ctx.stroke();
    }
    Filters.lastX = x; Filters.lastY = y;
}
   
/******************** END Filters *****************************************/


