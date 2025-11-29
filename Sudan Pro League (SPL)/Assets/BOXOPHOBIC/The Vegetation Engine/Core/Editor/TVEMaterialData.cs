// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using System.Collections.Generic;

namespace TheVegetationEngine
{
    [CreateAssetMenu(fileName = "Material Data", menuName = "BOXOPHOBIC/The Vegetation Engine/Material Data")]
    public class TVEMaterialDataContainer : ScriptableObject
    {
        public List<TVEMaterialData> materialData;
    }

    [System.Serializable]
    public class TVEMaterialData
    {
        public enum PropertyType
        {
            Value = 0,
            Range = 1,
            Vector = 2,
            Color = 3,
            Enum = 4,
            Toggle = 5,
            Space = 90,
            Category = 91,
        }

        public PropertyType type;
        public string prop;
        public string name;
        public float value;
        public float min;
        public float max;
        public bool snap;
        public Vector4 vector;
        public string file;
        public string options;
        public bool hdr;
        public bool space;
        public string category;
        public bool valid = false;

        public TVEMaterialData(string prop, bool valid)
        {
            type = PropertyType.Space;
            this.prop = prop;
            this.valid = valid;
        }

        public TVEMaterialData(string prop, string category, bool valid)
        {
            type = PropertyType.Category;
            this.prop = prop;
            this.category = category;
            this.valid = valid;
        }

        public TVEMaterialData(string prop, string name, float value, bool snap, bool space)
        {
            type = PropertyType.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.snap = snap;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, int min, int max, bool snap, bool space)
        {
            type = PropertyType.Range;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.min = min;
            this.max = max;
            this.snap = snap;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, Vector4 vector, bool space)
        {
            type = PropertyType.Vector;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, Vector4 vector, bool hdr, bool space)
        {
            type = PropertyType.Color;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.hdr = hdr;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, string options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.options = options;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, string file, string options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.file = file;
            this.options = options;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, bool space)
        {
            type = PropertyType.Toggle;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.space = space;
        }
    }
}