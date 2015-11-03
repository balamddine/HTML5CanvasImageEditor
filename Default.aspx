<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Image Editor</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <link href="css/glyphicons.css" rel="stylesheet" />
    <link href="css/jquery.Jcrop.css" rel="stylesheet" />
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/jquery.Jcrop.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/ImageEditor.js"></script>
    <script type="text/javascript" src="js/site.js"></script>

</head>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="javascript:void(0)">Image Editor</a>
            </div>
            <div>
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)">File<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:void(0)" id="a_open"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Open</a></li>
                            <li class="disabled" id="btn_save"><a href="javascript:void(0)"><span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;&nbsp;Save</a></li>
                            <li class="disabled" id="clear_Canvas"><a href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp; Clear Canvas</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)">Filter tools<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li id="desaturate" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-adjust"></span>&nbsp;&nbsp;Desaturate</a></li>
                            <li id="fliph" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-road"></span>&nbsp;&nbsp;FlipH</a></li>
                            <li id="flipv" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-road"></span>&nbsp;&nbsp;FlipV</a></li>
                            <li id="blur" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-tint"></span>&nbsp;&nbsp;Blur</a></li>
                            <li id="sharpen" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;Sharpen</a></li>
                            <li id="brightness" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicons sun"></span>&nbsp;&nbsp;Brighten</a></li>
                            <li id="threshold" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-link"></span>&nbsp;&nbsp;Threshold</a></li>
                            <li id="reset" class="disabled Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-repeat"></span>&nbsp;&nbsp;Reset</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)">Paint tools<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li id="pen" class="Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Pen</a></li>
                            <li id="alphabet" class="Menu"><a href="#AlphabetModal" data-toggle="modal" data-backdrop="static"><span class="glyphicon glyphicon-font"></span>&nbsp;&nbsp;Text</a></li>
                            <li id="Rect" class="Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp;Rectangle</a></li>
                            <li id="circle" class="Menu"><a href="javascript:void(0)"><span class="glyphicon glyphicons crop"></span>&nbsp;&nbsp;Circle</a></li>
                            <li id="gallery" class="disabled Menu"><a href="#GalleryModal" data-toggle="modal" data-backdrop="static"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp;Gallery</a></li>
                        </ul>
                    </li>

                    <li id="crop"   class="disabled Menu"><a href="#CropModal" data-toggle="modal" data-backdrop="static"><span class="glyphicon glyphicons crop"></span>&nbsp;&nbsp;Crop</a></li>
                    <li id="undo"  class="disabled Menu" ><a href="javascript:void(0);"><span class="glyphicon glyphicons undo"></span>&nbsp;&nbsp;Undo</a></li>
                    <li id="redo" class="disabled Menu"><a href="javascript:void(0);"><span class="glyphicon glyphicons redo"></span>&nbsp;&nbsp;Redo</a></li>
                        
                </ul>
            </div>
        </div>
    </nav>

    <div class="col-lg-12">

        <%--<div class="col-lg-2">
            <div class="panel panel-default">
                <div class="panel-body">
                </div>
            </div>

        </div>--%>
        <div class="row">
            <div class="col-lg-4">

                <div id="dv_canvas" style="border: 1px solid #E5E5E5">
                    <div id="sketch">
                        <canvas id="imageCanvas" class="cv_img"></canvas>
                    </div>
                    <br />
                    <div class="progress">
                        <div class="progress-bar" id="ProgressBar" role="progressbar" aria-valuenow="0"
                            aria-valuemin="0" aria-valuemax="100">
                            <span id="sp_progressCount"></span>
                        </div>
                    </div>
                </div>
                <br />
                <br />
                <br />
            </div>
            <%-- <div class="col-lg-4">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked Menu">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked Menu">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
        </div>
        <div class="row">
            <div class="col-lg-4 col-lg-offset-2">
                <div class="form-group" style="margin-left: 3%;">
                    <input type="file" class="form-control" id="UploadFile" style="display: none;" />
                </div>
            </div>
        </div>


        <div class="modal fade" id="GalleryModal" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Gallery</h4>
                    </div>
                    <div class="modal-body">

                        <ul class="nav nav-pills">
                            <li class="active"><a data-toggle="pill" href="#Items"><span class="glyphicon glyphicon-gift"></span>&nbsp;Items</a></li>
                            <li><a data-toggle="pill" href="#Humans"><span class="glyphicon glyphicon-user"></span>&nbsp;Humans </a></li>
                            <li><a data-toggle="pill" href="#Homes"><span class="glyphicon glyphicon-home"></span>&nbsp;Homes</a></li>
                            <li><a data-toggle="pill" href="#Plans"><span class="glyphicon glyphicon-plane"></span>&nbsp;Plans</a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="Items" class="tab-pane fade in active">
                                <br />
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-1 "></div>
                                        </div>
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-2"></div>
                                        </div>
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-3"></div>
                                        </div>
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-4"></div>
                                        </div>
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-5"></div>
                                        </div>

                                    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-6"></div>
                                        </div>
                                        <div class="col-md-2 gallery-item">
                                            <div class="ms ms-7"></div>
                                        </div>
                                        <div class="col-md-2 col-md-offset-1 gallery-item">
                                            <div class="ms ms-8"></div>
                                        </div>
                                        <div class="col-md-2 col-md-offset-1 gallery-item">
                                            <div class="ms ms-9"></div>
                                        </div>
                                        <div class="col-md-2 col-md-offset-1 gallery-item">
                                            <div class="ms ms-10"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="Humans" class="tab-pane fade">
                                Humans here..
                            </div>
                            <div id="Homes" class="tab-pane fade">
                                Homes here
                            </div>
                            <div id="Planes" class="tab-pane fade">
                                Planes here
                            </div>
                        </div>
                        <div id="dv_PreViewCanvas">
                            <canvas id="cv_Preview" style="border: 2px solid #E5E5E5; padding: 5px;"></canvas>
                        </div>
                        <div id="dv_btns" style="display: none">
                            <input type="button" id="btn_saveitm" class="btn btn-primary" value="confirm" />&nbsp;&nbsp;
                        </div>
                    </div>
                    <%--<div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>--%>
                </div>
            </div>
        </div>
        <div class="modal fade" id="CropModal" role="dialog" style="width: 500px; left: 30%;">
            <div class="modal-dialog " style="width: 500px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Crop Image</h4>
                    </div>
                    <div class="modal-body">
                        <div id="Crop_dv"></div>
                    </div>
                    <br />
                    <div id="dvCrp_btns" style="margin-left: 20px">
                        <input type="button" id="btn_saveCropitm" class="btn btn-primary" value="confirm" />&nbsp;&nbsp;
                            
                    </div>
                    <br />
                    <br />
                </div>
            </div>
        </div>
        <br />
        <div class="modal fade" id="AlphabetModal" role="dialog" >
            <div class="modal-dialog modal-lg" >
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Insert text</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div id="dv_Alphabet" class="col-lg-12">
                                <div class="form">
                                    <div class="form-group col-lg-3">
                                        <label>Text : </label>
                                        <input type="text" id="Alph_text" class="form-control" />
                                    </div>
                                    <div class="form-group col-lg-3" style="margin-left: 2px">
                                        <label>Color (Hex) : </label>
                                        <div class="input-group">
                                            <span class="input-group-addon">#</span>
                                            <input type="text" id="Alph_color" class="form-control" value="0000FF"/>
                                        </div>
                                    </div>
                                    <div class="form-group col-lg-2" style="margin-left: 2px">
                                        <label>Font-size : </label>
                                        <div class="input-group">
                                            <input type="number" id="Alph_size" class="form-control" min="8" value="8" />
                                            <span class="input-group-addon">px</span>
                                        </div>
                                    </div>
                                    <div class="col-lg-2" style="margin-top: 25px">
                                        <input type="button" class="btn btn-primary" value="Go" id="btn_AddText" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="alert alert-info" style="display: none" id="dv_Info_msg"><span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;<span id="Info_Msg"></span></div>
        </div>

    </div>

</body>
</html>

