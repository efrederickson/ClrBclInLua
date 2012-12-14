/*
 * User: elijah
 * Date: 12/13/2012
 * Time: 2:17 PM
 * Copyright 2012 LoDC
 */
using System;
using System.Diagnostics;
using System.IO;
using System.Collections.Generic;

namespace BuildReflectionInfo
{
    class Program
    {
        static List<string> filenames = new List<string>();
        //const string baseDir = "J:\\ClrBclInLua";
        const string baseDir = "../../../";
        static bool hadErr = false;
        static string errors = "";
        
        public static void Main(string[] args)
        {
            process(baseDir + "\\System");
            if (hadErr)
            {
                Console.WriteLine(errors);
                
                Console.Write("Press any key to continue . . . ");
                Console.ReadKey(true);
            }
            //Console.Read();
        }
        
        static void process(string dir)
        {
            foreach (string s in Directory.GetFiles(dir))
            {
                if (s.EndsWith(".lua"))
                {
                    if (s.EndsWith(".r.lua") == false)
                    {
                        if (s.EndsWith("init.lua") == false)
                        {
                            generateReflectionInfo(s);
                        }
                    }
                }
            }
            if (File.Exists(dir + "/init.lua"))
            {
                string text = File.ReadAllText(dir + "/init.lua");
                foreach (string fn in filenames)
                {
                    string p = System.IO.Path.ChangeExtension(fn, ".r");
                    p = p.Substring(p.IndexOf('\\') + 1);
                    p = p.Replace('\\', '.');
                    
                    string p2 = Path.ChangeExtension(p, "");
                    p2 = p2.Substring(0, p2.LastIndexOf('.'));
                    p2 = p2.Substring(0, p2.LastIndexOf('.'));
                    //Console.WriteLine(p2);
                    
                    //Console.WriteLine(p);
                    if (text.IndexOf(p) == -1)
                    {
                        text += "\n";
                        string tmp = p2 + " = " + p2 + " or { }\n";
                        //if (text.IndexOf(tmp) == -1)
                        //{
                        //    text += tmp;
                        //}
                        text += "require '" + p + "'";
                    }
                }
                text = text.Replace("\r\n", "\n");
                File.WriteAllText(dir + "/init.lua", text);
            }
            filenames.Clear();
            
            foreach (string d in Directory.GetDirectories(dir))
            {
                process(d);
            }
        }
        
        static void generateReflectionInfo(string f)
        {
            Console.WriteLine("Generating reflection info for '" + f + "'");
            Process p = new Process();
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "lua";
            psi.Arguments = baseDir + "\\reflection\\GenerateReflectionInfo.lua ";
            psi.Arguments += f;
            psi.RedirectStandardError = true;
            psi.UseShellExecute = false;
            psi.CreateNoWindow = true;
            psi.RedirectStandardOutput = true;
            p.StartInfo = psi;
            p.Start();
            TextReader tr = TextReader.Synchronized(p.StandardOutput);
            TextReader tr2 = TextReader.Synchronized(p.StandardError);
            p.WaitForExit();
            string tmp2 = tr.ReadToEnd();
            if (!String.IsNullOrEmpty(tmp2))
                Console.WriteLine(tr.ReadToEnd());
            string tmp = tr2.ReadToEnd();
            if (!string.IsNullOrEmpty(tmp))
                Console.WriteLine(tmp);
            if (p.ExitCode != 0)
            {
                hadErr = true;
                errors += tmp;
            }
            else if (p.ExitCode == 0)
            {
                if (File.Exists(Path.ChangeExtension(f, ".r.lua")))
                    filenames.Add(f);
            }
            Console.WriteLine("Done with '" + f + "' Exit code: " + p.ExitCode);
        }
    }
}