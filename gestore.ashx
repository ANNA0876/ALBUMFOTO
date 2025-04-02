<%@ WebHandler Language="C#" Class="gestore" %>

using System;
using System.Web;
using System.Data;

public class gestore : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //ho bisogno di sapere quale chiave leggere(lo fa uno alla volta)
        int chiave = int.Parse(context.Request.QueryString["c"].ToString());

        //Leggere il record del DB
        DB db = new DB();
        db.query = "select * from FOTO where K_Foto=" + chiave.ToString();
        DataTable DT = new DataTable();
        DT = db.SQLselect();

        //creare tre variabili 
        byte[] ImgData = (byte[])DT.Rows[0]["ImgData"];  //fuFoto è un file Upload
        //così possiamo dargli un titolo alla foto
        string TitoloFoto = DT.Rows[0]["TitoloFoto"].ToString();
        //tipo di dato salvato (?)
        string Tipo = DT.Rows[0]["Tipo"].ToString();

        //qui dovremmo chiederci quale tipo di file stiamo trattando
        //perchè la costruzione del file in memoria varia a seconda che sia zip,img,pdf...

        //creare il context cioè costruisce il documento
        context.Response.Buffer = true; //i dati vengono memorizzati temporaneamente e alla fine inviati tutti insieme
        context.Response.Charset = ""; //browser userà il set di caratteri predefinito per la risposta
        context.Response.AppendHeader("Content-Disposition", "attachment;filename" + TitoloFoto);
        //Aggiunge un'intestazione alla risposta HTTP per indicare al browser che il contenuto deve essere trattato come un file da scaricare.
        //Il nome del file da scaricare sarà quello che è contenuto nella variabile titolo. 
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache); //Impedisce al browser di salvare nella cache il contenuto
        context.Response.ContentType = Tipo; //Imposta il tipo di contenuto della risposta.Questo dice al browser di che tipo di file si tratta.
        context.Response.BinaryWrite(ImgData);//Scrive i dati binari nel corpo della risposta HTTP. Questi dati vengono quindi inviati al browser.
        context.Response.Flush(); //vuol dire che i dati che erano stati memorizzati precedentemente nel buffer vengono inviati effettivamente al browser.
        context.Response.End(); //segnala la fine dell'elaborazione della risposta.

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}