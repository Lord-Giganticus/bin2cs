global using System.Text;
using bin2cs;

foreach (var arg in args)
{
    if (File.Exists(arg) && !Directory.Exists(arg))
    {
        Template t = new FileInfo(arg);
        (Span<byte> span, string name) = t.Process();
        name += ".cs";
        using var f = File.Create(name);
        f.Write(span);
    }
}