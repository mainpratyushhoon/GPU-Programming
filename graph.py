import subprocess
import matplotlib.pyplot as plt

Ns = [i for i in range(1, 100)]
cpu_times = []
gpu_times = []

for N in Ns:
    cpu_time = gpu_time = 0
    for i in range(0,5):
        print(f"Running N = {N}")
        result = subprocess.run(["./main", str(N)], capture_output=True, text=True)
        lines = result.stdout.splitlines()
        for line in lines:
            if "CPU TIME" in line:
                temp1 = float(line.split(":")[1].strip().replace("ms", ""))
                cpu_time=cpu_time+temp1
            if "GPU TIME" in line:
                temp = float(line.split(":")[1].strip().replace("ms", ""))
                gpu_time = gpu_time+temp
    gpu_time=gpu_time/5
    cpu_time=cpu_time/5
    cpu_times.append(cpu_time)
    gpu_times.append(gpu_time)

# Plotting
plt.figure(figsize=(10, 6))
plt.axvline(x=64, color='grey', linestyle='--', label='Reference Line')
plt.plot(Ns, cpu_times, label="CPU Time", marker="o")
plt.plot(Ns, gpu_times, label="GPU Time", marker="o")
plt.xlabel("Matrix Size (N x N)")
plt.ylabel("Time (ms)")
plt.title("CPU vs GPU Matrix Multiplication Time")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
