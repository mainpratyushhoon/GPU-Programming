import subprocess
import matplotlib.pyplot as plt

Ns = [i for i in range(1, 1025)]
cpu_times = []
gpu_times = []
speedup=[]
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
    speedup.append(cpu_time/gpu_time)
#print(speedup)
# Plotting
plt.figure(figsize=(10, 6))
plt.axhline(y=1, color='grey', linestyle='--', label='Reference Line')
plt.plot(Ns, speedup, label="Speed-Up = CPU Time / GPU Time")
plt.xlabel("Matrix Size (N x N)")
plt.ylabel("SPEED-UP")
plt.title("CPU vs GPU Matrix Multiplication Time")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
