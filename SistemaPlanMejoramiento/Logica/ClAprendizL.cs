using SistemaPlanMejoramiento.Modelo;
using System;
using System.Collections.Generic;
using System.Web.Services.Description;
namespace SistemaPlanMejoramiento
{
    public class ClAprendizL
    {
        ClAprendizD oDatos = new ClAprendizD();
        public string MtInsertar(Aprendiz oAprendiz)
        {
            string mensaje = "";
            try
            {
                if (oAprendiz.NumeroDocumento == "" || oAprendiz.NumeroDocumento == null)
                {
                    mensaje = "el numero de documento es obligatorio";
                }
                else if (oAprendiz.Nombres == "" || oAprendiz.Nombres == null)
                {
                    mensaje = "los nombres son obligatorios";
                }
                else if (oAprendiz.Apellidos == "" || oAprendiz.Apellidos == null)
                {
                    mensaje = "los apellidos son obligatorios";
                }
                else if (oAprendiz.IdFicha <= 0)
                {
                    mensaje = "debe seleccionar una ficha";
                }
                else if (oAprendiz.Correo == "" || oAprendiz.Correo == null)
                {
                    mensaje = "el correo es obligatorio";
                }
                else if (!oAprendiz.Correo.Contains("@"))
                {
                    mensaje = "el correo ingresado no es valido";
                }
                else
                {
                    oAprendiz.Estado = "En Formación";
                    oDatos.MtInsertar(oAprendiz);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
        public List<Aprendiz> MtConsultar()
        {
            List<Aprendiz> lista = new List<Aprendiz>();
            try
            {
                lista = oDatos.MtConsultar();
            }
            catch (Exception ex)
            {
                _ = ex;
            }
            return lista;
        }
        public string MtModificar(Aprendiz oAprendiz)
        {
            string mensaje = "";
            try
            {
                if (oAprendiz.Nombres == "" || oAprendiz.Nombres == null)
                {
                    mensaje = "los nombres no pueden estar vacios";
                }
                else if (oAprendiz.Apellidos == "" || oAprendiz.Apellidos == null)
                {
                    mensaje = "los apellidos no pueden estar vacios";
                }
                else
                {
                    oDatos.MtModificar(oAprendiz);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
        public string MtEliminar(int idAprendiz)
        {
            string mensaje = "";
            try
            {
                oDatos.MtEliminar(idAprendiz);
                mensaje = "ok";
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
        public string MtCambiarEstado(int idAprendiz, string nuevoEstado)
        {
            string mensaje = "";
            try
            {
                if (nuevoEstado == "" || nuevoEstado == null)
                {
                    mensaje = "debe seleccionar un estado";
                }
                else
                {
                    oDatos.MtCambiarEstado(idAprendiz, nuevoEstado);
                    mensaje = "ok";
                }
            }
            catch (Exception ex)
            {
                mensaje = "error: " + ex.Message;
            }
            return mensaje;
        }
    }
}