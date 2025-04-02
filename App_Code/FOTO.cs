using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
public class FOTO
{
    public int K_Foto;
    public int K_Album;
    public string TitoloFoto;
    public DateTime DataFoto;
    public string Privacy;
    public byte[] ImgDate;
    public string Tipo;
    public int NLike;

    public FOTO()
    {
        
    }

    //mostra foto
    public DataTable ShowPhoto()
    {
        DB db = new DB();
        db.query = "IMG100";
        return db.SQLselect();
    }
}