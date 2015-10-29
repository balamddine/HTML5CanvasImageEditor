<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Image Editor</title>
    <link href="css/Bootstrapv3.3.5.css" rel="stylesheet" />
    <link href="css/site.css" rel="stylesheet" />
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-ui.js"></script>
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
                    <li><a href="javascript:void(0)"  id="a_open"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Open</a></li>
                    <li class="disabled" id="btn_save"><a href="javascript:void(0)"><span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;&nbsp;Save</a></li>
                    <li class="disabled" id="clear_Canvas"><a href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp; Clear Canvas</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="col-lg-12">
        <div class="col-lg-2">
            <div class="panel panel-default">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked Menu">
                        <li id="desaturate"  class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-adjust"></span>&nbsp;&nbsp;Desaturate</a></li>
                        <li id="fliph" class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-road"></span>&nbsp;&nbsp;FlipH</a></li>
                        <li id="flipv" class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-road"></span>&nbsp;&nbsp;FlipV</a></li>
                        <li id="blur" class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-eye-close"></span>&nbsp;&nbsp;Blur</a></li>
                        <li id="sharpen" class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;Sharpen</a></li>
                        <li id="reset" class="disabled"><a href="javascript:void(0)"><span class="glyphicon glyphicon-repeat"></span>&nbsp;&nbsp;Reset</a></li>
                    </ul>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked Menu">
                        <li id="gallery" class="disabled"><a href="#GalleryModal" data-toggle="modal" data-backdrop="static"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp;Gallery</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <div id="dv_canvas" style="border: 1px solid #E5E5E5">
                    <div id="sketch">
                        
                        <canvas id="imageCanvas" class="pixastic"></canvas>
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
                <div class="alert alert-danger" id="dv_up_Error" style="display: none;"><span class="glyphicon glyphicon-alert"></span>&nbsp;Invalid image File</div>
                <div class="alert alert-danger" id="dv_Error" style="display: none;"><span class="glyphicon glyphicon-alert"></span>&nbsp;Failed To Save Image</div>
            </div>

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
                            <input type="button" id="btn_cancel" class="btn btn-default" value="cancel" />
                        </div>
                    </div>
                    <%--<div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

