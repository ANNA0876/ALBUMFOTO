using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        FOTO f = new FOTO();
        DataTable DT = new DataTable();
        DT = f.SelectAll();

        lit.Text += "<div class=\"container\">"; // Apertura del container Bootstrap
        lit.Text += "<h1 class=\"fw-light text-center text-lg-start mt-4 mb-0\">Galleria Foto</h1>"; // Titolo (opzionale)
        lit.Text += "<hr class=\"mt-2 mb-5\">"; // Linea orizzontale (opzionale)
        lit.Text += "<div class=\"row text-center text-lg-start\">"; // Apertura della riga Bootstrap

        foreach (DataRow riga in DT.Rows)
        {
            string chiave = riga["K_Foto"].ToString();

            lit.Text += "<div class=\"col-lg-3 col-md-4 col-6\">"; // Colonna Bootstrap (regola le dimensioni per diversi schermi)
            lit.Text += "<a href=\"#\" class=\"d-block mb-4 h-100\">"; // Link (puoi cambiare l'href se vuoi linkare a qualcosa)
            lit.Text += "<img class=\"img-fluid img-thumbnail\" src='gestore.ashx?c=" + chiave + "' alt=''>"; // Tag img con classi Bootstrap
            lit.Text += "</a>";
            lit.Text += "</div>";
        }

        lit.Text += "</div>"; // Chiusura della riga Bootstrap
        lit.Text += "</div>"; // Chiusura del container Bootstrap
    }
}