using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;

namespace SistemaPlanMejoramiento
{
    public class ClInstructorL
    {
        ClInstructorD oDatos = new ClInstructorD();

        public string MtInsertar(Instructor oInstructor)
        {
            string mensaje = "";
            try
            {
                if (oInstructor.NumeroDocumento == "" || oInstructor.NumeroDocumento == null)
                {
                    mensaje = "el numero de documento es obligatorio";
                }
                else if (oInstructor.Nombres == "" || oInstructor.Nombres == null)
                {
                    mensaje = "los nombres son obligatorios";
                }
                else if (oInstructor.Apellidos == "" || oInstructor.Apellidos == null)
                {
                    mensaje = "los apellidos son obligatorios";
                }
                else if (oInstructor.Correo == "" || oInstructor.Correo == null)
                {
                    mensaje = "el correo es obligatorio";
                }
                else if (!oInstructor.Correo.Contains("@"))
                {
                    mensaje = "el correo no es valido";
                }
                else
                {
                    oDatos.MtInsertar(oInstructor);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public List<Instructor> MtConsultar()
        {
            List<Instructor> lista = new List<Instructor>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
            }
            return lista;
        }

        public string MtModificar(Instructor oInstructor)
        {
            string mensaje = "";
            try
            {
                if (oInstructor.Nombres == "" || oInstructor.Nombres == null)
                {
                    mensaje = "los nombres no pueden estar vacios";
                }
                else if (!oInstructor.Correo.Contains("@"))
                {
                    mensaje = "el correo no es valido";
                }
                else
                {
                    oDatos.MtModificar(oInstructor);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }

        public string MtEliminar(int idInstructor)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idInstructor);
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