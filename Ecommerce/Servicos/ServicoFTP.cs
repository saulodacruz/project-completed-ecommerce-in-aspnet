using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class ServicoFTP : IDisposable
    {
        public string _caminhoArquivo;
        private string caminhoRaizFTP = ConfigurationManager.AppSettings["CaminhoRaizFTP"];
        private string username = ConfigurationManager.AppSettings["FtpUserName"].ToString();
        private string password = ConfigurationManager.AppSettings["FtpPassword"].ToString();

        public ServicoFTP(string caminhoArquivo)
        {
            this._caminhoArquivo = caminhoArquivo;
        }
        public bool DeleteFile()
        {
            try
            {
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(caminhoRaizFTP + _caminhoArquivo);
                request.Credentials = new NetworkCredential(username, password);
                request.Method = WebRequestMethods.Ftp.DeleteFile;
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                response.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool DeleteDirectory()
        {
            try
            {
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(caminhoRaizFTP + _caminhoArquivo);
                request.Credentials = new NetworkCredential(username, password);
                request.Method = WebRequestMethods.Ftp.RemoveDirectory;
                FtpWebResponse response = (FtpWebResponse)request.GetResponse();
                response.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool SaveFile(byte[] byteArray)
        {
            try
            {
                WebRequest request = WebRequest.Create(caminhoRaizFTP + _caminhoArquivo);
                request.Method = WebRequestMethods.Ftp.UploadFile;
                request.Credentials = new NetworkCredential(username, password);
                Stream reqStream = request.GetRequestStream();
                reqStream.Write(byteArray, 0, byteArray.Length);
                reqStream.Close();
                return true;
            }
            catch(Exception ex)
            {
                return false;
            }
        }
        public bool CreateDirectory(string directory)
        {
            try
            {
                FtpWebRequest request = (FtpWebRequest)WebRequest.Create(caminhoRaizFTP + directory);
                request.Method = WebRequestMethods.Ftp.ListDirectory;
                request.Credentials = new NetworkCredential(username, password);
                using (FtpWebResponse response = (FtpWebResponse)request.GetResponse())
                {
                    return true;
                }
            }
            catch
            {
                try
                {
                    WebRequest request = WebRequest.Create(caminhoRaizFTP + directory);
                    request.Method = WebRequestMethods.Ftp.MakeDirectory;
                    request.Credentials = new NetworkCredential(username, password);
                    request.GetResponse();
                    return true;

                }
                catch 
                {
                    return false;
                }
            }
        }
        bool disposed = false;
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (disposed)
                return;
            if (disposing)
            {
                _caminhoArquivo = null;
                caminhoRaizFTP = null;
                username = null;
                password = null;
            }
            disposed = true;
        }
    }
}
