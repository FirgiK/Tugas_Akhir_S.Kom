# Evaluasi Komparatif Action Selection NPC Boss pada Game 2D: FSM vs Utility-Based AI vs Multi-Armed Bandit

Repository ini memuat artefak kode simulasi game 2D (Godot Engine) serta seluruh skrip analisis statistik kuantitatif (Jupyter Notebook) untuk pengujian performa tiga metode kecerdasan buatan (*action selection*) pada NPC Boss.

---

## 📌 Ringkasan Penelitian

Penelitian ini melakukan evaluasi komparatif terhadap tiga arsitektur pengambilan keputusan (*action selection*) pada model NPC boss yang identik dalam lingkungan game 2D terkontrol:
1. **Finite State Machine (FSM)**
2. **Utility-Based AI**
3. **Multi-Armed Bandit (MAB)** dengan algoritma $\epsilon$-greedy

Evaluasi dilakukan melalui **30 sesi simulasi per metode (total 90 sesi)** berbasis parameter *Action Entropy*, *Transition Entropy*, *Decision Latency*, *Memory Consumption*, dan *Survival Time*. Perbedaan signifikan antar metode diuji menggunakan statistik non-parametrik **Kruskal-Wallis** dan uji lanjut **Dunn's test dengan koreksi Bonferroni**.

---

## 📁 Struktur Artefak Repository

- **`project_eksperimen/`**: *Source code* lingkungan uji game 2D berbasis Godot Engine (skrip GDScript FSM, Utility-AI, MAB, aset, dan UI).
- **`pengolahan_data_eksperimen/`**: 
  - `HitungHasil.ipynb`: Skrip pengolahan data mentah, uji hipotesis statistik, dan pembangkitan grafik.
  - `raw_FSM.csv`, `raw_MAB.csv`, `raw_Utility.csv`: Data mentah hasil simulasi 90 sesi.
  - `deskriptif.csv`, `metrics_per_session.csv`, `summary_*.csv`: Output pemrosesan statistik deskriptif.
  - `*.png`: Visualisasi distribusi aksi, latensi, dan konvergensi MAB.

---

## 📊 Hasil dan Pembahasan Eksperimen

### 1. Ringkasan Statistik Deskriptif

Berdasarkan pemrosesan 90 sesi simulasi, berikut adalah perbandingan nilai statistik per metode:

| Parameter Evaluasi | Finite State Machine (FSM) | Utility-Based AI | Multi-Armed Bandit (MAB) |
| :--- | :---: | :---: | :---: |
| **Action Entropy** | Sedang | **Tinggi (Variatif)** | Rendah (Konvergen) |
| **Transition Entropy** | Terstruktur | **Tinggi** | Rendah |
| **Decision Latency** | **Paling Rendah (Cepat)** | Tinggi | Sedang |
| **Memory Consumption** | **Sangat Rendah** | Tinggi | Sedang |
| **Survival Time** | Stabil | Fluktuatif | Rendah |

---

### 2. Visualisasi Grafik Performa

#### A. Distribusi Pemilihan Aksi (Action Distribution)

<img width="1650" height="825" alt="action_distribution" src="https://github.com/user-attachments/assets/6024b577-e8ae-4bce-b734-b0c3a5cdd2cb" />
|*Gambar 1: Perbandingan sebaran proporsi aksi yang dieksekusi oleh NPC boss pada setiap metode.*

#### B. Sebaran Metric & Latensi (Boxplots)

<img width="2250" height="1200" alt="boxplots" src="https://github.com/user-attachments/assets/1c600d70-1d63-4722-8a1b-1f3e79c3e55d" />
|*Gambar 2: Boxplot rentang variabilitas metrik performa dan efisiensi komputasi.*

#### C. Karakteristik Konvergensi MAB & Survival Rate
| Konvergensi $\epsilon$-greedy (MAB) | Survival Time Across Sessions |
| :---: | :---: |
<img width="1200" height="750" alt="mab_convergence" src="https://github.com/user-attachments/assets/f8c24377-cdb1-4116-ac5a-767bcf8177e7" />|<img width="1800" height="750" alt="linechart_survival" src="https://github.com/user-attachments/assets/89350ebf-047f-47cb-9589-aea5ae0bde9a" />

| *Gambar 3: Eksplorasi vs Eksploitasi MAB.* | *Gambar 4: Stabilitas ketahanan NPC.* |

---

### 3. Hasil Uji Hipotesis Inferensial

Hasil uji non-parametrik **Kruskal-Wallis** menunjukkan perbedaan yang **signifikan secara statistik ($p < 0.05$)** pada seluruh parameter evaluasi antara FSM, Utility-Based AI, dan MAB:

1. **Efisiensi Komputasi (Latency & Memory):** FSM mencatatkan waktu keputusan (*decision latency*) paling rendah dan konsumsi memori paling efisien dibanding Utility-Based AI.
2. **Variabilitas Perilaku (Entropy):** Utility-Based AI menghasilkan *Action Entropy* tertinggi, menciptakan respons dinamis sesuai situasi pertarungan.
3. **Stabilitas & Konvergensi:** MAB mengalami konvergensi prematur (*premature convergence*) pada skenario *short time horizon*, yang menyebabkan variabilitas aksi menurun drastis setelah mengeksploitasi aksi tertentu.

---

## 🔑 Temuan Utama & Kesimpulan

1. **Variabilitas Deterministik vs Stokastik:** Variabilitas perilaku yang kaya tidak selalu membutuhkan mekanisme stokastik (seperti MAB), melainkan dapat dicapai secara efektif melalui pendekatan deterministik yang dirancang terstruktur seperti **Utility-Based AI**.
2. **Trade-off Arsitektur AI Game 2D:**
   - **FSM** sangat ideal untuk pengembang yang memprioritaskan efisiensi komputasi maksimal dan perilaku deterministik yang dapat diprediksi.
   - **Utility-Based AI** sangat cocok untuk pertempuran NPC boss yang membutuhkan variasi perilaku dinamis, meski memerlukan biaya komputasi latensi yang lebih tinggi.
   - **MAB ($\epsilon$-greedy)** membutuhkan *time horizon* simulasi yang lebih panjang agar fase eksplorasi tidak mengalami konvergensi prematur pada aksi suboptimal.

## 🎓 Informasi Tugas Akhir

- **Penulis:** Firgi Khoiru Rijal (NIM: 10222102)
- **Program Studi:** Informatika
- **Perguruan Tinggi:** Sekolah Tinggi Teknologi Cipasung (STT Cipasung), Tasikmalaya
- **Dosen Pembimbing I:** Reza Febriana, M.Kom.
- **Dosen Pembimbing II:** Haerul Febriansyah, S.Kom.

---

## 📚 Referensi Utama

1. Russell, S., & Norvig, P. *Artificial Intelligence: A Modern Approach*. Pearson.
2. Mark, D. *Behavioral Mathematics for Game AI*. Charles River Media.
3. Sutton, R. S., & Barto, A. G. *Reinforcement Learning: An Introduction*. MIT Press.
