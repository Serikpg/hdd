import pandas as pd
import matplotlib.pyplot as plt

# Load CSV
df = pd.read_csv("filter_output.csv")

# Plot each column
plt.figure(figsize=(10, 6))

for column in df.columns:
    plt.plot(df.index, df[column], marker='.', label=column)

plt.title("Numerical Samples from CSV")
plt.xlabel("Index")
plt.ylabel("Value")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
