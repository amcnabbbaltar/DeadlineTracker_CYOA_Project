using UnityEditor;
using UnityEngine;
using UnityEditor.AssetImporters;

[ScriptedImporter(1, "twee")]
public class TweeImporter : ScriptedImporter
{
    public override void OnImportAsset(AssetImportContext ctx)
    {
        string text = System.IO.File.ReadAllText(ctx.assetPath);
        var asset = new TextAsset(text);
        ctx.AddObjectToAsset("main", asset);
        ctx.SetMainObject(asset);
    }
}
