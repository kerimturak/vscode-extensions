import os

def sanitize(name):
    return name.replace(os.sep, "_").replace(".", "_").replace("-", "_")

def to_mermaid(path, parent_id=None, lines=None):
    if lines is None:
        lines = ["graph TD"]

    current_id = sanitize(path)
    if parent_id:
        lines.append("{} --> {}".format(parent_id, current_id))

    if os.path.isdir(path):
        for item in os.listdir(path):
            item_path = os.path.join(path, item)
            to_mermaid(item_path, current_id, lines)
    return lines

# Kullanılacak kök dizin
root_dir = "./"  # veya "./project", "./verilog_rtl" gibi
mermaid_lines = to_mermaid(root_dir)

# Sonuç çıktısı
print("\n".join(mermaid_lines))