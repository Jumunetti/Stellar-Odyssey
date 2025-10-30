import wave
import json
from vosk import Model, KaldiRecognizer
from pydub import AudioSegment
import os

# ======================
# CONFIGURAZIONE
# ======================
audio_orig = r"C:\Users\fedeb\Downloads\Nuova-registrazione.wav"  # File originale
audio_mono = r"C:\Users\fedeb\Downloads\Nuova-registrazione-mono.wav"  # File convertito
model_path = r"C:\Users\fedeb\Downloads\vosk-model-small-it-0.22"   # Modello Vosk

# ======================
# CONVERSIONE AUTOMATICA
# ======================
audio = AudioSegment.from_file(audio_orig)
audio = audio.set_channels(1)      # Mono
audio = audio.set_frame_rate(16000)  # 16kHz
audio.export(audio_mono, format="wav")
print("✅ Audio convertito in mono a 16kHz!")

# ======================
# CARICAMENTO MODELLO
# ======================
if not os.path.exists(model_path):
    print("❌ Modello non trovato! Controlla il percorso.")
    exit()

model = Model(model_path)

# ======================
# TRASCRIZIONE
# ======================
wf = wave.open(audio_mono, "rb")

rec = KaldiRecognizer(model, wf.getframerate())
text = ""

while True:
    data = wf.readframes(4000)
    if len(data) == 0:
        break
    if rec.AcceptWaveform(data):
        res = json.loads(rec.Result())
        text += res.get("text", "") + " "

res = json.loads(rec.FinalResult())
text += res.get("text", "")

# ======================
# SALVATAGGIO TRASCRIZIONE
# ======================
output_file = r"C:\Users\fedeb\Downloads\trascrizione.txt"
with open(output_file, "w", encoding="utf-8") as f:
    f.write(text)

print("=== Trascrizione completata! ===")
print(f"📄 File salvato in: {output_file}")
print(text)

