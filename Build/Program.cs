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

namespace Build
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
            bool _err = false;
            process(baseDir + "\\System");
            if (hadErr)
            {
                _err = true;
                Console.WriteLine(errors);
            }
            hadErr = false;
            build(baseDir + "\\System", "System");
            buildf(baseDir + "/init.lua", "");
            buildf(baseDir + "/interact.lua", "");
            if (hadErr)
            {
                Console.WriteLine(errors);
                Console.Read();
            }
            else
            {
                if (_err)
                {
                    Console.WriteLine("Done, errors occured though");
                    Console.Read();
                }
                else
                    Console.WriteLine("Done, build sucessful!");
            }
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
            /*
            if (File.Exists(dir + "/init.lua"))
            {
                string text = File.ReadAllText(dir + "/init.lua");
                foreach (string fn in filenames)
                {
                    string p = System.IO.Path.ChangeExtension(fn, ".r.lua");
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
            */
            filenames.Clear();
            
            foreach (string d in Directory.GetDirectories(dir))
            {
                process(d);
            }
        }
        
        static void generateReflectionInfo(string f)
        {
            Console.WriteLine("Generating reflection info for '" + Path.GetFileName(f) + "'");
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
            //Console.WriteLine("Done with '" + f + "' Exit code: " + p.ExitCode);
        }
        
        static void buildf(string f, string dir)
        {
            string s = "bin/";
            Console.WriteLine("Compiling " + Path.GetFileName(f));
            if (Directory.Exists(Path.Combine(baseDir, s, dir) + "/") == false)
                Directory.CreateDirectory(Path.Combine(baseDir, s, dir) + "/");
            Process p = new Process();
            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "luac";
            psi.Arguments += "-o " + Path.Combine(baseDir, s, dir) + "/";
            psi.Arguments += Path.ChangeExtension(Path.GetFileName(f), ".luac");
            psi.Arguments += " ";
            psi.Arguments += f;
            psi.Arguments += " ";
            string r_file = Path.GetDirectoryName(f) + "/" + Path.GetFileNameWithoutExtension(f) + ".r.lua";
            if (File.Exists(r_file))
                psi.Arguments += r_file;
            psi.RedirectStandardError = true;
            psi.UseShellExecute = false;
            psi.CreateNoWindow = true;
            psi.RedirectStandardOutput = true;
            p.StartInfo = psi;
            //Console.WriteLine(dir);
            //Console.WriteLine(psi.Arguments);
            //return;
            p.Start();
            TextReader tr = TextReader.Synchronized(p.StandardOutput);
            TextReader tr2 = TextReader.Synchronized(p.StandardError);
            p.WaitForExit();
            if (File.Exists(r_file))
                File.Delete(r_file);
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
            }
        }
        
        static void build(string dir, string base_)
        {
            //Console.WriteLine(dir);
            //Console.WriteLine(base_);
            //Console.WriteLine(Path.GetFileName(dir));
            //Console.Read();
            foreach (string f in Directory.GetFiles(dir))
            {
                if (f.EndsWith(".r.lua") == false)
                {
                    if (f.EndsWith(".lua"))
                    {
                        //Console.WriteLine(Path.Combine(baseDir, "bin", base_));
                        //Console.WriteLine(f);
                        buildf(f, base_);
                    }
                }
            }
            foreach (string d in Directory.GetDirectories(dir))
            {
                build(d, base_ + "/" + Path.GetFileName(d));
            }
        }
    }
}