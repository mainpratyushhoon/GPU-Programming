import subprocess
import matplotlib.pyplot as plt

Ns = [i for i in range(1, 1025)]
throughputs = []

for N in Ns:
    throughput = 0
    for i in range(0,1):
        print(f"Running N = {N}")
        result = subprocess.run(["ncu","./main.exe", str(N)], capture_output=True, text=True)
        lines = result.stdout.splitlines()
        for line in lines:
            parts=line.split("%")
            if "Compute (SM) Throughput" in line:
                throughput = throughput+ float(parts[1].strip())
    throughput=throughput/1
    throughputs.append(throughput)

# Plotting
plt.figure(figsize=(10, 6))
plt.axvline(x=64, color='grey', linestyle='--', label='Reference Line')
plt.plot(Ns, throughputs, label="Compute Throughput", marker="o")
plt.xlabel("Matrix Size (N x N)")
plt.ylabel("Percentage")
plt.title("GPU Compute Throughput")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
