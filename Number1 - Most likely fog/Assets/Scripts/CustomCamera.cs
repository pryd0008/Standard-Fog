using UnityEngine;
using System.Collections;

public class CustomCamera : MonoBehaviour
{
    [SerializeField]
    private Shader fog;

    private Camera cam;

    void Start()
    {
        cam = GetComponent<Camera>();

        cam.depthTextureMode = DepthTextureMode.Depth;
    }

    [SerializeField]
    public Material mat;
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        mat.SetVector("_CameraPos", this.transform.position);
        Graphics.Blit(src, dest, mat);
    }
}
