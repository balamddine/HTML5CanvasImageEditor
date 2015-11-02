$(document).ready(function () {
    var canvas = $("#imageCanvas")[0];
    var ctx = canvas.getContext("2d");
    var uploadInput = $('#UploadFile');
    var width = 382;
    var height = 295;
    var ProgressPerc = 0;
    var Pentool = false;
    $("#imageCanvas").width = width;
    $("#imageCanvas").height = height;
    $("#imageCanvas").attr("width", width + "px");
    $("#imageCanvas").attr("height", height + "px");
    $(".dv_crop").draggable({ containment: "#imageCanvas" }).resizable();
    
    uploadInput.on('change', function (e) {
        RemoveDisabledClass();
        handleImage(e);
    });
    
    $("#a_open").click(function () {
        uploadInput.click();
    });
    $("#btn_save").click(function () {
        if ($("#btn_save").hasClass("disabled")) return;
        $("#dv_Error").css("display", "none");
        var image = document.getElementById("imageCanvas").toDataURL("image/png");
       // image = image.replace('data:image/png;base64,', '');
        window.location.href = image;
        /*
        $.ajax({
            type: 'POST',
            url: 'Default.aspx/SaveImg',
            data: '{ "imgdata" : "' + image + '" }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (data) {
                window.location.href = data.d;

            },
            error: function (request, status, error) {
                $("#dv_Error").css("display", "block");

            }

        }); //ENd Ajax
        */
    }); //End Click event
    $(".Menu").find("li").each(function () {
        $(this).click(function () {
            if ($(this).hasClass("disabled")) return;
            RemoveActiveClass();
            var id = $(this).attr("id");
            $(this).addClass("active");

            PaintImage(id);
        });
    });
    $("#clear_Canvas").click(function () {
        if ($(this).hasClass("disabled")) return;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    });
    $('.gallery-item').draggable();
    $("#cv_Preview").droppable({ drop: function (event, ui) {

            var img = ui.draggable;
            var offs = $(this).offset();
            var uiPos = img.offset();
            var x = uiPos.left - offs.left;
            var y = uiPos.top - offs.top;
            DrawGalleryImg(img.find("div"), $(this), x, y);
            
            $("#dv_btns").css("display", "block");
            Filters.Push($("#imageCanvas")[0]);
    } });
    $("#btn_saveitm").click(function () {
        ctx.drawImage(document.getElementById("cv_Preview"), 0, 0);
        $("#GalleryModal").modal("hide");
       
    });
    function handleImage(e) {
        var fileTypes = ['jpg', 'jpeg', 'png', 'bmp', 'gif'];
        var file = e.target.files[0];
        var extension = file.name.substring(file.name.lastIndexOf('.')).replace(".","").toLowerCase();
        var isSuccess = fileTypes.indexOf(extension) > -1;
        if (!isSuccess)
        {

            $("#dv_up_Error").css("display", "block");
            return;
        }
        $("#dv_up_Error").css("display", "none");
        var reader = new FileReader();
        reader.onload = function (event) {
            var img = new Image();
            img.onload = function () {
                // var canvas = ctx.canvas;
                var hRatio = canvas.width / img.width;
                var vRatio = canvas.height / img.height;
                var ratio = Math.min(hRatio, vRatio);
                var centerShift_x = (canvas.width - img.width * ratio) / 2;
                var centerShift_y = (canvas.height - img.height * ratio) / 2;
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                resizeContainer(img.width * ratio, img.height * ratio);
                
                ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, img.width * ratio, img.height * ratio);
                var d = ctx.getImageData(0,0,canvas.width,canvas.height);
                Filters.SetInitialImageData(d);
                $('#ProgressBar').css('width', '100%');
                $("#sp_progressCount").html("100%");

                Filters.Push(canvas);
            }
            img.src = event.target.result;
        }
        reader.onprogress = function (event) {
            var str, p;

            if (event.lengthComputable) {   // does the progress know what's coming
                p = parseInt(((event.loaded / event.total) * 100), 10);   // get the percent loaded
               // str = Math.floor(p * 100) + "%";    // create the text

            } else {
                p = event.loaded / 1024;   // show the kilobytes
                str = Math.floor(p) + "k"; // the text
                p = ((p / 50) % 1) * 100;   // make the progress bar cycle around every 50K
            }

            $('#ProgressBar').css('width', p + '%');
            $("#sp_progressCount").html(p+"%");
        }
        reader.readAsDataURL(e.target.files[0]);
    }
    function resizeContainer(width,height)
    {
        $("#imageCanvas").attr("width", width + "px");
        $("#imageCanvas").attr("height",height + "px");
        $("#imageCanvas").css("padding", "15px");

        $("#cv_Preview").attr("width", width + "px");
        $("#cv_Preview").attr("height", height + "px");


        $("#dv_canvas").css("width", width+30 + "px");
        $("#dv_canvas").css("height", height+30 + "px");
    }
    function RemoveActiveClass() {
        $(".Menu").find("li").each(function () {
            $(this).removeClass("active");
        });
    }
    function RemoveDisabledClass() {
        $(".Menu").find("li").each(function () {
            $(this).removeClass("disabled");
        });
        $("#btn_save").removeClass("disabled");
        $("#clear_Canvas").removeClass("disabled");
    }
    function PaintImage(filter) {
        $('.progress').css("display", "none");
        
        var c = $("#imageCanvas");
        switch (filter)
        {
            case "gallery": showPreviewCanvas(); return;
            case "crop": Crop(); return;
            case "pen": Filters.Pen(c, ctx, "#000000", 1); return;
            case "undo": Filters.Undo(ctx); return;
            case "redo": Filters.Redo(ctx); return;
            default: Filters.SetFilter(c, ctx, filter); return;
        }
            
    }
    function Crop() {
        var Img = new Image();
        Img.onload = function () {};
        Img.src = canvas.toDataURL();
        Img.id = "img_Crop";
        $("#Crop_dv").html(Img);
        $('#img_Crop').Jcrop({
                onChange: saveCoords,
                //onSelect: showCoords
            });
    }
    var x, y,x2,y2, w, h;
    function saveCoords(c) {
        x = c.x;
        y = c.y;
        x2 = c.x2;
        y2 = c.y2;
        w = c.w;
        h = c.h;
    }
    $("#btn_saveCropitm").click(function () {
        var img = document.getElementById("img_Crop");
        var c = $("#imageCanvas");
        Filters.Crop(c,ctx,img, x, y, w, h);
        $("#CropModal").modal("hide");
    });
    function showPreviewCanvas() {
        $("#dv_btns").css("display", "none");
        var previewCv = $("#cv_Preview");
        var previewCtx = $("#cv_Preview")[0].getContext("2d");

        previewCtx.drawImage($("#imageCanvas")[0], 0, 0);
      
    }
    function DrawGalleryImg(sender,ParentCanvas,XposDraw,YposDraw)
    {
        
        var bg = sender.css('background-image');
        bg = bg.replace('url(', '').replace(')', '').replace('"', '').replace('"', '');
        var w = parseInt(sender.css('width').replace('px', ''));
        var h = parseInt(sender.css('height').replace('px', ''));
        var backgroundPos = sender.css('backgroundPosition').split(" ");
        //now contains an array like ["0%", "50px"]
        var xPos = backgroundPos[0],
            yPos = backgroundPos[1];
        xPos = parseInt(xPos.replace("px", "")) < 0 ? -parseInt(xPos.replace("px", "")) : parseInt(xPos.replace("px", ""));
        yPos = parseInt(yPos.replace("px", "")) < 0 ? -parseInt(yPos.replace("px", "")) : parseInt(yPos.replace("px", ""));
        var PreviewCtx = ParentCanvas[0].getContext("2d");
        var img = new Image();
        img.onload = function () {
            PreviewCtx.drawImage(img, xPos, yPos, w, h, XposDraw, YposDraw, w, h);
            
        }
        img.src = bg;
        PreviewCtx.restore();
    }
    
});
