using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string SaveImg(string imgdata)
    {

        string Path = "UploadedImages/";
        string folderPath = HttpContext.Current.Server.MapPath(Path);
        Guid gid=Guid.NewGuid();
        string fileNameWitPath = folderPath + "img_" +gid  + ".png";

        FileStream fs = new FileStream(fileNameWitPath, FileMode.Create);
        BinaryWriter bw = new BinaryWriter(fs);

        byte[] data = Convert.FromBase64String(imgdata);
       
        bw.Write(data);
        bw.Close();
        bw.Dispose();
        return  "/" + Path +"img_"+ gid + ".png";
    }
   
}