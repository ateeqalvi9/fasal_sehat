# Fasal Sehat (فصل صحت)
## Technical & Academic Guide: Questions & Answers
**Prepared for Mobile Computing & AI Course Projects**

---

## Q1. Do we save data in a database?

**Yes, but strictly inside the local Android phone.** Because "Fasal Sehat" is engineered as an offline-first mobile application for farmers in rural fields without internet access, there is **NO cloud database** (no Firebase, Supabase, or AWS) and zero network permissions.

### 1.1 What goes into the local SQLite database (`sqflite`):
- **Diagnosis History Table (`history`)**: Automatically created on the device. Each time a farmer scans a leaf, a row is inserted:
  - `id`: Auto-incrementing primary key.
  - `label`: Predicted disease class name (e.g. `Tomato___Early_blight`).
  - `confidence`: Probability score (e.g. `0.88`).
  - `severity`: Severity classification (`healthy`, `mild`, `severe`).
  - `image_path`: File path to the locally saved compressed JPEG photo.
  - `thumb_path`: File path to the 96x96 thumbnail JPEG.
  - `created_at`: Epoch timestamp in milliseconds.
- **Strict Storage Optimization**: Raw image bytes (BLOBs) are **NEVER** stored in SQLite. Instead, photos are compressed (max 800px, JPEG quality 80) and written to the app's internal documents directory. Only the local file path strings are recorded in the database.
- **Storage Cap (200 Entries)**: The SQLite history table is capped at 200 rows using FIFO (First-In, First-Out) eviction to keep storage bounded on low-cost 16 GB ROM phones.

### 1.2 What is bundled as static assets (`remedies.json`):
- Disease metadata, Urdu translations, treatment steps with icons, and audio paths are bundled inside `assets/data/remedies.json`.
- This file is read-only, loaded once at startup, and cached in memory.

### 1.3 What does NOT go into the mobile database:
- **Training Images**: The tens of thousands of training photos live exclusively in Google Colab or Kaggle. Only the final compiled, quantized model (`crop_model.tflite` <= 5 MB) is copied into the Flutter app.
- **User Accounts / Servers**: No login credentials, user tables, or analytics tracking exist.

---

## Q2. Do we need to train a model, or is everything already available?

**You do not train from scratch, but you MUST fine-tune a model.** This technique is called **Transfer Learning** and forms the core requirement for your AI course evaluation.

### 2.1 Component Breakdown & Responsibility

| Component | Already Exists? | Your Exact Role | Course Alignment |
|---|---|---|---|
| **MobileNetV2 Base Architecture** | **Yes** (Pretrained by Google on ImageNet) | Download via `tf.keras.applications.MobileNetV2(weights="imagenet", include_top=False)`. It already understands edges, textures, shapes, and leaf morphology. | **AI Course** (Backbone) |
| **Crop Disease Classifier Head** | **No** | Fine-tune in Google Colab on your chosen crop dataset (2–3 hours). Freeze base layers, train custom Dense layers, fine-tune the top 20 layers, evaluate with confusion matrix, and quantize to `.tflite`. | **AI Course** (Core ML Deliverable) |
| **Flutter Offline App & Pipeline** | **No** | Build the offline Flutter app with camera viewfinder, leaf guide overlay, background isolate image processing, TFLite interpreter, SQLite history, and audio player. | **Mobile Computing Course** (Core App Deliverable) |

### 2.2 Why downloading a pre-trained disease model is risky:
While generic pre-trained crop disease models exist online, downloading a готовый black-box model weakens your project defense:
1. **Academic Evaluation**: Course evaluators will ask for training loss/accuracy graphs, confusion matrices, precision/recall/F1 metrics, and data augmentation code.
2. **Preprocessing Mismatch**: Third-party models often have undocumented normalization rules (e.g. `[0, 1]` vs `[-1, 1]`), causing random wrong classifications inside Flutter.
3. **Emergency Backup**: Train your own MobileNetV2 in Colab and keep a downloaded model only as a fail-safe backup.

---

## Q3. Where is the data? Which diseases should we target?

In standard image classification datasets, **the folder names ARE the disease labels**. You do not need to search for a separate disease inventory.

### 3.1 Primary Data Sources:
1. **PlantVillage Dataset (Kaggle)**:
   - Gold standard starting point: 54,305 images across 38 classes (14 crop species).
   - [PlantVillage on Kaggle (Abdallah Ali)](https://www.kaggle.com/datasets/abdallahalidev/plantvillage-dataset)
   - [PlantVillage on Kaggle (Emma Rex)](https://www.kaggle.com/datasets/emmarex/plantdisease/data)
   - *Limitation*: Photographed on plain lab backgrounds.
2. **PlantDoc Dataset (Field Conditions)**:
   - Contains real-world agricultural field photos under natural sunlight, varying backgrounds, and leaf clusters.
   - [PlantDoc on GitHub](https://github.com/pratikkayal/PlantDoc-Object-Detection-Dataset)
   - Mixing cropped PlantDoc photos bridges the domain gap for real farmer fields.
3. **Pakistani Regional Crops (Mendeley Data & Kaggle)**:
   - PlantVillage covers Tomato, Potato, Pepper, and Corn.
   - For Pakistani cash crops (Wheat, Cotton, Rice, Sugarcane), search Kaggle or Mendeley Data (e.g., "Cotton Leaf Disease Dataset" or "Rice Leaf Disease Dataset").

### 3.2 Recommended Crop Selection (Balanced Scope):
For a university semester project, select **3 to 4 crops** with **8 to 14 classes total**, plus one crucial negative class:
- **Tomato (4 classes)**: `Tomato___Early_blight`, `Tomato___Late_blight`, `Tomato___Yellow_Leaf_Curl_Virus`, `Tomato___healthy`
- **Potato (3 classes)**: `Potato___Early_blight`, `Potato___Late_blight`, `Potato___healthy`
- **Pepper / Bell Pepper (2 classes)**: `Pepper__bell___Bacterial_spot`, `Pepper__bell___healthy`
- **Negative Class (`not_a_leaf`)**: **Crucial!** Include 500+ random non-leaf images (shoes, hands, dirt, walls, clothing). This guarantees that when a farmer accidentally points the camera at a non-leaf object, the app triggers the `UNCERTAIN_RESULT` screen instead of falsely predicting a crop disease.

---

## Q4. Where do the cures come from?

There is no pre-existing dataset that automatically links images to treatments. You author the remedy knowledge base manually by referencing vetted agronomy sources.

### 4.1 Authoritative Verification Sources:
1. **CABI Plantwise Knowledge Bank**:
   - Over 6,000 peer-reviewed factsheets in multiple languages covering crop diseases, pest symptoms, and cultural/chemical management.
   - [CABI Plantwise Knowledge Bank](https://www.plantwise.org/knowledgebank/)
2. **PARC (Pakistan Agricultural Research Council) & Provincial Extension**:
   - Official farmer advisories, spray schedules, and seasonal disease alerts published by provincial agriculture extension departments (Punjab, Sindh, KP).
3. **University of Agriculture Faisalabad (UAF)**:
   - Plant pathology extension bulletins and research guides.

### 4.2 Rules for Authoring Farmer Remedies:
1. **Icon-First & Concise**: 2 to 3 short steps paired with clear visual icons (💧 Watering, ✂️ Pruning, 🧴 Spraying).
2. **Generic Chemical Classes Only**: Never specify commercial brand names (which change across regions) or concentrated dosages (to prevent crop chemical burn liability). Prescribe generic solutions like "copper-based fungicide" or "neem oil spray".
3. **Safety Gear Mandate**: Any chemical recommendation must include the step: *"Wear protective mask and gloves while spraying."*
4. **Advisory Disclaimer**: Every result screen displays: *"For severe cases consult your local agriculture extension officer."*
5. **Urdu Audio Script**: Translate each remedy into simple colloquial Urdu and record a 15-second clear audio clip for low-literacy farmers.

---

## Strategic Step-by-Step Order of Work

```
Step 1: Choose 3–4 crops (8–14 classes + `not_a_leaf`)
    │
Step 2: Download PlantVillage subset + gather non-leaf images
    │
Step 3: Fine-tune MobileNetV2 in Google Colab (Transfer Learning)
    │
Step 4: Evaluate with confusion matrix & export quantized `crop_model.tflite` (<= 5 MB)
    │
Step 5: Author and verify `remedies.json` (English + Urdu) via CABI Plantwise
    │
Step 6: Build the Flutter App (Camera, Isolate Preprocessing, SQLite History, Audio)
    │
Step 7: Record 10–15s Urdu audio clips (`assets/audio/ur/*.opus`)
    │
Step 8: Test in Airplane Mode on an Android phone & compile the final project report
```
