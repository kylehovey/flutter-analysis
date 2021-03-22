# Analysis of ECG

using CSV
using Tables
using DSP
using AbstractFFTs
using Plots
using WAV

sample_rate = 512
T = 1/sample_rate

window = 2000:4000

all_flutter_data = CSV.File("./flutter.csv", types=[Float64]) |> Tables.matrix
all_sinus_data = CSV.File("./sinus.csv", types=[Float64]) |> Tables.matrix

flutter_data = all_flutter_data[window]
sinus_data = all_sinus_data[window]
flutter_fft = fft(flutter_data)
sinus_fft = fft(sinus_data)

wavwrite(all_flutter_data / (maximum(abs.(all_flutter_data))), "flutter.wav", Fs=sample_rate)
wavwrite(all_sinus_data / (maximum(abs.(all_sinus_data))), "sinus.wav", Fs=sample_rate)

plot(abs.(flutter_fft)[1:500], yaxis=:log)
savefig("flutter_fft_plot.png")

plot(abs.(sinus_fft)[1:500], yaxis=:log)
savefig("sinus_fft_plot.png")

plot(abs.(flutter_fft)[1:500], yaxis=:log)
plot!(abs.(sinus_fft)[1:500], yaxis=:log)
savefig("combined_fft_plot.png")
