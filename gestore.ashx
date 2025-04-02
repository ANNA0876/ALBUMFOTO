<%@ WebHandler Language="C#" Class="gestore" %>

using System;
using System.Web;
using System.Data;

public class gestore : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        int chiave = int.Parse(context.Request.QueryString["c"].ToString());
        // leggere il record dal db

        DB db = new DB();
        db.query = "select ImgData, TitoloFoto, Tipo from FOTO where K_Foto =" + chiave.ToString();
        DataTable DT = new DataTable();
        DT = db.SQLselect();

        // creare tre variabili
        byte[] imgdata = (byte[]) DT.Rows[0]["ImgData"];
        string titolo = DT.Rows[0]["TitoloFoto"].ToString();
        string tipo = DT.Rows[0]["Tipo"].ToString();
        
        // qui dovremmo chiederci che tipo di file stiamo trattando perchè la costruzione del file in memoria varia a seconda che sia zip/image/pdf...
        // creare il context
        context.Response.Buffer = true; // un'area di memoria dove costruisce l'oggetto
        context.Response.Charset = "";
        context.Response.AppendHeader("Content-Disposition", "attachment;filename=" + titolo); // intestazione all'immagine che stiamo creando
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        context.Response.ContentType = tipo;
        context.Response.BinaryWrite(imgdata);
        context.Response.Flush();
        context.Response.End();


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}