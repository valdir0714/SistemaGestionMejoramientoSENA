using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.IO;

namespace SistemaPlanMejoramiento
{
    public class ClEvidenciaL
    {
        ClEvidenciaD oDatos = new ClEvidenciaD();

        public string MtInsertar(Evidencia oEvidencia)
        {
            string mensaje = "";
            try
            {
                if (oEvidencia.IdPlan <= 0)
                {
                    mensaje = "debe seleccionar un plan";
                }
                else if (oEvidencia.NombreArchivo == "" || oEvidencia.NombreArchivo == null)
                {
                    mensaje = "debe seleccionar un archivo";
                }
                else
                {
                    string extension = Path.GetExtension(oEvidencia.NombreArchivo).ToLower();
                    if (extension != ".pdf" && extension != ".docx" && extension != ".jpg" && extension != ".png" && extension != ".zip")
                    {
                        mensaje = "el tipo de archivo no esta permitido, solo pdf, docx, jpg, png o zip";
                    }
                    else
                    {
                        oEvidencia.FechaSubida = DateTime.Now;
                        oDatos.MtInsertar(oEvidencia);
                        mensaje = "ok";
                    }
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<Evidencia> MtConsultar(int idPlan)
        {
            List<Evidencia> lista = new List<Evidencia>();
            try
            {
                lista = oDatos.MtConsultar(idPlan);
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtEliminar(int idEvidencia)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idEvidencia);
                mensaje = "ok";
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
    }
}