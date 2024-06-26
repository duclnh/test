using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class CropManger : MonoBehaviour
{
    public Tilemap cropMap;
    public Tile hiddenInteractableTile;
    public List<CropData> cropDatas = new List<CropData>();
    public List<Item> items = new List<Item>();

    public Dictionary<Vector3Int, CropItem> cropDataDictionary = new Dictionary<Vector3Int, CropItem>();
    private Dictionary<string, Item> sellProduct = new Dictionary<string, Item>();

    void Start()
    {
        if (cropMap != null)
        {
            foreach (var position in cropMap.cellBounds.allPositionsWithin)
            {
                TileBase tile = cropMap.GetTile(position);
                if (tile != null && tile.name == "Interactable_visible")
                {
                    cropMap.SetTile(position, hiddenInteractableTile);
                }
            }
            foreach (var item in items)
            {
                string key = item.data.name.Replace("_Sell", " Seeds");
                sellProduct.Add(key, item);
            }
        }
    }
    void Update()
    {
        foreach (KeyValuePair<Vector3Int, CropItem> position in cropDataDictionary)
        {
            TimeSpan timeDifference = position.Value.dateTime - DateTime.UtcNow;
            if (timeDifference.TotalSeconds <= 0 && position.Value.currentStage < position.Value.cropData.tiles.Count - 1)
            {
                position.Value.currentStage++;
                cropMap.SetTile(position.Key, position.Value.cropData.tiles[position.Value.currentStage]);
                if (position.Value.currentStage != position.Value.cropData.tiles.Count - 1)
                {
                    position.Value.dateTime = position.Value.dateTime.AddSeconds(position.Value.cropData.growTime);
                }
                else
                {
                    GameManager.instance.menuSettings.SoundComplete(position.Key);
                }
            }
        }

    }
    public void Seed(Vector3Int position, string nameSeed)
    {
        GameManager.instance.menuSettings.SoundImpactGround();
        CropData cropData = GetCropDataByName(nameSeed);
        CropItem cropItem = new CropItem(cropData, nameSeed);
        cropItem.dateTime = cropItem.dateTime.AddSeconds(cropData.growTime);
        cropMap.SetTile(position, cropData.tiles[0]);
        cropDataDictionary.Add(position, cropItem);
        GameManager.instance.player.inventoryManager.Remove("Toolbar", nameSeed);
        GameManager.instance.uiManager.RefreshInventoryUI("Toolbar");
    }
    public void Seed(PlantTable plantTable)
    {
        Vector3Int vector = new Vector3Int(plantTable.PositionX, plantTable.PositionY, plantTable.PositionZ);
        CropData cropData = GetCropDataByName(plantTable.Crop);
        CropItem cropItem = new CropItem(cropData, plantTable.Crop);
        cropItem.dateTime = plantTable.Datetime;
        cropItem.currentStage = plantTable.CurrentStage;
        cropItem.quantityHarvested = plantTable.QuantityHarvested;
        cropMap.SetTile(vector, cropData.tiles[cropItem.currentStage]);
        cropDataDictionary.Add(vector, cropItem);
    }
    public string GetTileName(Vector3Int position)
    {
        if (cropMap != null)
        {
            TileBase tile = cropMap.GetTile(position);
            if (tile != null)
            {
                return tile.name;
            }
        }
        return "";
    }
    public CropData GetCropDataByName(string name) => cropDatas.Find(x => x.nameItem == name);
    public bool HarvestPlant(Vector3Int position)
    {
        if (!cropDataDictionary.ContainsKey(position))
        {
            return false;
        }
        CropItem cropItem = cropDataDictionary[position];
        TimeSpan timeDifference = cropItem.dateTime - DateTime.UtcNow;
        if (timeDifference.TotalSeconds <= 0
            && cropItem.currentStage == cropItem.cropData.tiles.Count - 1)
        {
            GameManager.instance.player.DropItem(sellProduct[cropDataDictionary[position].itemName], cropDataDictionary[position].quantityHarvested);
            cropMap.SetTile(position, hiddenInteractableTile);
            cropDataDictionary.Remove(position);
            return true;
        }
        else
        {
            GameManager.instance.menuSettings.SoundFail();
            GameManager.instance.nofification.Show("Not enough time to harvest");
        }
        return false;
    }
}
