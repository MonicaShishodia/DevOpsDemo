using System;
using System.IO;
namespace DevOpsDemo
{
    public class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("Please provide path");
                Console.ReadLine();
            }
            else
            {
                Program obj = new Program();
                obj.getFiles(args[0]);
            }
        }
        public bool getFiles(string args)
        {
            try
            {
                DirectoryInfo dir = new DirectoryInfo(args);
                DirectoryInfo[] dirInfo = dir.GetDirectories();
                Console.WriteLine();
                Console.WriteLine("############################");
                Console.WriteLine();
                Console.WriteLine("Number of directories : " + dirInfo.Length);
                Console.WriteLine();
                Console.WriteLine("############################"); Console.WriteLine();
                foreach (DirectoryInfo di in dirInfo)
                {
                    Console.WriteLine(di.FullName);
                }
                Console.WriteLine();
                Console.WriteLine();
                FileInfo[] files = dir.GetFiles();
                Console.WriteLine("############################");
                Console.WriteLine();
                Console.WriteLine("Number of files : " + files.Length);
                Console.WriteLine();
                Console.WriteLine("############################"); Console.WriteLine();
                foreach (FileInfo fi in files)
                {
                    Console.WriteLine(fi.FullName);
                }
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine("Invalid Path :" + e.Message);
                return false;
            }
        }
    }
}
