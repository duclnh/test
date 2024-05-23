using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class Item : MonoBehaviour
{
    public ItemData data;
    [HideInInspector] public Rigidbody2D rigidBD;
    private void Awake(){
        rigidBD = GetComponent<Rigidbody2D>();
    }
}
