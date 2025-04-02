using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;


public class DB
{
    SqlConnection conn = new SqlConnection();
    //il command ha bisogno di parametri allora usiamo pubblic così il programmat. può lavorarci
    public SqlCommand cmd = new SqlCommand();
    SqlDataAdapter DA = new SqlDataAdapter();
    public string query; //creo un campo così mi prenderà la query che mi serve 
    public DB()
    {
        conn.ConnectionString = "Data source = DESKTOP-0E2GJI9\\SQLEXPRESS; Initial Catalog =FOTOALBUM; Integrated Security=true;";
        cmd.Connection = conn;
        cmd.CommandType = CommandType.Text;
    }
    public DataTable SQLselect()
    {

        DataTable DT = new DataTable(); //HAI SPOSTATO QUESTO DA CLASS DB
        cmd.CommandText = query;
        DA.SelectCommand = cmd;
        DA.Fill(DT);
        return DT;
    }

    public void SQLCommand()
    {
        cmd.CommandText = query;
        //parametri
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
    }// void perchè non deve restituire niente

}