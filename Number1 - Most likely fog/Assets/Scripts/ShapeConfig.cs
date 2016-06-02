using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ShapeConfig : MonoBehaviour
{
    [SerializeField]
    Transform camera;

    Renderer renderer;

    void Start()
    {
        renderer = GetComponent<Renderer>();
    }

	void Update ()
    {
        renderer.material.SetVector("_CameraPos", camera.position);
    }
}
