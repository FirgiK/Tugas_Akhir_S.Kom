Repository ini berisi *source code*, eksperimen, serta implementasi dataset/model untuk penyusunan Tugas Akhir (Skripsi).

## 📌 Deskripsi Proyek
- **Penulis:** Firgi Khoiru Rijal
- **Lingkungan Eksekusi:** Linux Mint / Python

---

## 📁 Struktur Repository & File Experiments
Berikut adalah pemetaan otomatis dari file dan folder yang terdapat dalam repository ini:

```text
.editorconfig
.gitattributes
.gitignore
UI/experiment_ui.gd
UI/experiment_ui.gd.uid
UI/experiment_ui.tscn
asset/Char1/Parts/Swordsman_lvl2_Death_body.png
asset/Char1/Parts/Swordsman_lvl2_Death_body.png.import
asset/Char1/Parts/Swordsman_lvl2_Death_head.png
asset/Char1/Parts/Swordsman_lvl2_Death_head.png.import
asset/Char1/Parts/Swordsman_lvl2_Death_red.png
asset/Char1/Parts/Swordsman_lvl2_Death_red.png.import
asset/Char1/Parts/Swordsman_lvl2_Death_sword.png
asset/Char1/Parts/Swordsman_lvl2_Death_sword.png.import
asset/Char1/Parts/Swordsman_lvl2_Death_sword_back.png
asset/Char1/Parts/Swordsman_lvl2_Death_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_body.png
asset/Char1/Parts/Swordsman_lvl3_Death_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_head.png
asset/Char1/Parts/Swordsman_lvl3_Death_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_red.png
asset/Char1/Parts/Swordsman_lvl3_Death_red.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Death_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_sword.png
asset/Char1/Parts/Swordsman_lvl3_Death_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Death_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Death_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Hurt_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Hurt_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Idle_body.png
asset/Char1/Parts/Swordsman_lvl3_Idle_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Idle_head.png
asset/Char1/Parts/Swordsman_lvl3_Idle_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Idle_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Idle_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Idle_sword.png
asset/Char1/Parts/Swordsman_lvl3_Idle_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Idle_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Idle_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_body.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_head.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_normal_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_normal_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_swing.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_swing.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_sword.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Run_Attack_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_body.png
asset/Char1/Parts/Swordsman_lvl3_Run_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_head.png
asset/Char1/Parts/Swordsman_lvl3_Run_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Run_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_sword.png
asset/Char1/Parts/Swordsman_lvl3_Run_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Run_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Run_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_body.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_head.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_normal_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_normal_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_swing.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_swing.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_sword.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Walk_Attack_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_body.png
asset/Char1/Parts/Swordsman_lvl3_Walk_body.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_head.png
asset/Char1/Parts/Swordsman_lvl3_Walk_head.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_shadow.png
asset/Char1/Parts/Swordsman_lvl3_Walk_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_sword.png
asset/Char1/Parts/Swordsman_lvl3_Walk_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_Walk_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_Walk_sword_back.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_body.png
asset/Char1/Parts/Swordsman_lvl3_attack_body.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_head.png
asset/Char1/Parts/Swordsman_lvl3_attack_head.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_normal_shadow.png
asset/Char1/Parts/Swordsman_lvl3_attack_normal_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_shadow.png
asset/Char1/Parts/Swordsman_lvl3_attack_shadow.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_swing.png
asset/Char1/Parts/Swordsman_lvl3_attack_swing.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_sword.png
asset/Char1/Parts/Swordsman_lvl3_attack_sword.png.import
asset/Char1/Parts/Swordsman_lvl3_attack_sword_back.png
asset/Char1/Parts/Swordsman_lvl3_attack_sword_back.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Death_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Death_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Hurt_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Hurt_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Idle_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Idle_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Run_Attack_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Run_Attack_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Run_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Run_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Walk_Attack_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Walk_Attack_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_Walk_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_Walk_with_shadow.png.import
asset/Char1/With_shadow/Swordsman_lvl3_attack_with_shadow.png
asset/Char1/With_shadow/Swordsman_lvl3_attack_with_shadow.png.import
asset/Char2/idle/._BossEnemy_idle.png
asset/Char2/idle/._spritesheet-5.png
asset/Char2/idle/._spritesheet-6.png
asset/Char2/idle/._spritesheet-7.png
asset/Char2/idle/._spritesheet-8.png
asset/Char2/idle/BossEnemy_idle.png
asset/Char2/idle/BossEnemy_idle.png.import
asset/Char2/idle/spritesheet-5.png
asset/Char2/idle/spritesheet-5.png.import
asset/Char2/idle/spritesheet-6.png
asset/Char2/idle/spritesheet-6.png.import
asset/Char2/idle/spritesheet-7.png
asset/Char2/idle/spritesheet-7.png.import
asset/Char2/idle/spritesheet-8.png
asset/Char2/idle/spritesheet-8.png.import
asset/Char2/stomp/._BossEnemy_stomp.png
asset/Char2/stomp/._spritesheet-10.png
asset/Char2/stomp/._spritesheet-11.png
asset/Char2/stomp/._spritesheet-12.png
asset/Char2/stomp/._spritesheet-9.png
asset/Char2/stomp/BossEnemy_stomp.png
asset/Char2/stomp/BossEnemy_stomp.png.import
asset/Char2/stomp/spritesheet-10.png
asset/Char2/stomp/spritesheet-10.png.import
asset/Char2/stomp/spritesheet-11.png
asset/Char2/stomp/spritesheet-11.png.import
asset/Char2/stomp/spritesheet-12.png
asset/Char2/stomp/spritesheet-12.png.import
asset/Char2/stomp/spritesheet-9.png
asset/Char2/stomp/spritesheet-9.png.import
asset/Char2/swipe/._BossEnemy_swipe.png
asset/Char2/swipe/._spritesheet-13.png
asset/Char2/swipe/._spritesheet-14.png
asset/Char2/swipe/._spritesheet-15.png
asset/Char2/swipe/._spritesheet-16.png
asset/Char2/swipe/BossEnemy_swipe.png
asset/Char2/swipe/BossEnemy_swipe.png.import
asset/Char2/swipe/spritesheet-13.png
asset/Char2/swipe/spritesheet-13.png.import
asset/Char2/swipe/spritesheet-14.png
asset/Char2/swipe/spritesheet-14.png.import
asset/Char2/swipe/spritesheet-15.png
asset/Char2/swipe/spritesheet-15.png.import
asset/Char2/swipe/spritesheet-16.png
asset/Char2/swipe/spritesheet-16.png.import
asset/Char2/walk/._BossEnemy_walk.png
asset/Char2/walk/._spritesheet-2.png
asset/Char2/walk/._spritesheet-3.png
asset/Char2/walk/._spritesheet-4.png
asset/Char2/walk/._spritesheet.png
asset/Char2/walk/BossEnemy_walk.png
asset/Char2/walk/BossEnemy_walk.png.import
asset/Char2/walk/spritesheet-2.png
asset/Char2/walk/spritesheet-2.png.import
asset/Char2/walk/spritesheet-3.png
asset/Char2/walk/spritesheet-3.png.import
asset/Char2/walk/spritesheet-4.png
asset/Char2/walk/spritesheet-4.png.import
asset/Char2/walk/spritesheet.png
asset/Char2/walk/spritesheet.png.import
asset/Field/Scene Overview.png
asset/Field/Scene Overview.png.import
asset/Field/Texture/Extra/TX Plant with Shadow.png
asset/Field/Texture/Extra/TX Plant with Shadow.png.import
asset/Field/Texture/Extra/TX Props with Shadow.png
asset/Field/Texture/Extra/TX Props with Shadow.png.import
asset/Field/Texture/TX Plant.png
asset/Field/Texture/TX Plant.png.import
asset/Field/Texture/TX Player.png
asset/Field/Texture/TX Player.png.import
asset/Field/Texture/TX Props.png
asset/Field/Texture/TX Props.png.import
asset/Field/Texture/TX Shadow Plant.png
asset/Field/Texture/TX Shadow Plant.png.import
asset/Field/Texture/TX Shadow.png
asset/Field/Texture/TX Shadow.png.import
asset/Field/Texture/TX Struct.png
asset/Field/Texture/TX Struct.png.import
asset/Field/Texture/TX Tileset Grass.png
asset/Field/Texture/TX Tileset Grass.png.import
asset/Field/Texture/TX Tileset Stone Ground.png
asset/Field/Texture/TX Tileset Stone Ground.png.import
asset/Field/Texture/TX Tileset Wall.png
asset/Field/Texture/TX Tileset Wall.png.import
char/brain.gd
char/brain.gd.uid
char/fsm.gd
char/fsm.gd.uid
char/mab.gd
char/mab.gd.uid
char/npc_1.gd
char/npc_1.gd.uid
char/npc_1.tscn
char/npc_2.gd
char/npc_2.gd.uid
char/npc_2.tscn
char/utillity.gd
char/utillity.gd.uid
icon.svg
icon.svg.import
logs/logger.gd
logs/logger.gd.uid
mod.gd
mod.gd.uid
project.godot
stage/camera_2d.gd
stage/camera_2d.gd.uid
stage/stage.gd
stage/stage.gd.uid
stage/stage.tscn
