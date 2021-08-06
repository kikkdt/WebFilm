using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebFilm_DAL
{
    public class clsMovie_Categories
    {
        public static int Insert(int idPhim, string[] arrIdTheLoai)
        {
            SqlConnection conn = null;
            int res = 0;
            try
            {
                conn = new SqlConnection
                {
                    ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
                };
                conn.Open();

                string str = "";
                foreach (string idTheLoai in arrIdTheLoai)
                {
                    str += "(" + idPhim + "," + idTheLoai + "),";
                }
                str = str.Remove(str.Length - 1);

                SqlCommand sqlCommand = new SqlCommand("INSERT INTO tb_Phim_TheLoai (idPhim, idTheLoai) VALUES" + str, conn) { CommandType = CommandType.Text };

                res = sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn != null)
                    conn.Close();
            }

            return res;
        }

        public static int DeleteByMovie(int idPhim)
        {
            SqlConnection conn = null;
            int res = 0;
            try
            {
                conn = new SqlConnection
                {
                    ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
                };
                conn.Open();

                SqlCommand sqlCommand = new SqlCommand("up_DeleteCategoriesByMovie", conn) { CommandType = CommandType.StoredProcedure };

                sqlCommand.Parameters.AddWithValue("@idPhim", idPhim);

                res = sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn != null)
                    conn.Close();
            }

            return res;
        }

        public static DataTable GetMovies(int idTheLoai)
        {
            SqlConnection conn = null;
            DataSet ds = new DataSet();
            try
            {
                conn = new SqlConnection
                {
                    ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
                };
                conn.Open();

                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM tb_Phim_TheLoai WHERE idTheLoai=@idTheLoai", conn) { CommandType = CommandType.Text };
                sqlCommand.Parameters.AddWithValue("@idTheLoai", idTheLoai);

                SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                sda.Fill(ds);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn != null)
                    conn.Close();
            }
            return ds.Tables[0];
        }

        public static DataTable GetCategories(int idPhim)
        {
            SqlConnection conn = null;
            DataSet ds = new DataSet();
            try
            {
                conn = new SqlConnection
                {
                    ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
                };
                conn.Open();

                SqlCommand sqlCommand = new SqlCommand("SELECT * FROM tb_Phim_TheLoai WHERE idPhim=@idPhim", conn) { CommandType = CommandType.Text };
                sqlCommand.Parameters.AddWithValue("@idPhim", idPhim);

                SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                sda.Fill(ds);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn != null)
                    conn.Close();
            }
            return ds.Tables[0];
        }
    }
}