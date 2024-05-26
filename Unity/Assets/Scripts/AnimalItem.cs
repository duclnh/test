using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimalItem
{
    public AnimalData animalData;
    public string itemName;
    public DateTime dateTime;
    public int currentStage;
    public int quantityHarvested;
    public int priceHarvested;
    public AnimalItem(AnimalData animalData, string itemName){
        this.animalData = animalData;
        this.dateTime = DateTime.UtcNow;
        this.currentStage = 0;
        this.quantityHarvested = animalData.quantity;
        this.itemName = itemName;
        this.priceHarvested = animalData.price;
    }
}