import tkinter as tk
import random  # Importa il modulo random
import re  # Importa il modulo delle espressioni regolari
from tkinter import filedialog  # Importa il modulo filedialog

# Definizione delle costanti per i tipi di celle
CELL_EMPTY = 0
CELL_WALL = 1
CELL_GOAL = 2
CELL_START = 3
CELL_PATH = 4 
CELL_PATH_COMPLETED = 5
CELL_VISITED = 6

class MazeEditor:
    def __init__(self, root):
        self.root = root
        self.width = 10
        self.height = 10
        self.cell_dim = 10
        self.grid = None
        self.current_tool = CELL_WALL  # Inizia con il muro come strumento corrente
        # Creazione del menu laterale
        self.tool_frame = tk.Frame(root)
        self.tool_frame.pack(side=tk.LEFT, padx=10)

        # Pulsanti di azione
        tk.Button(self.tool_frame, text="Reset", command=lambda: self.resetBoard()).pack()
        tk.Button(self.tool_frame, text="Salva", command=self.save_maze).pack()
        tk.Button(self.tool_frame, text="Carica", command=self.load_maze_from_file).pack()
        tk.Button(self.tool_frame, text="Soluzione", command=self.load_solution_from_file).pack()
        # Aggiungi bottoni per le iterazioni
        self.log_button = tk.Button(self.tool_frame, text="Load Log ", command=self.load_log_file)
        self.log_button.pack()

        self.prev_button = tk.Button(self.tool_frame, text="Prev", command=self.load_prev_iteration)
        self.prev_button.pack()
        self.next_button = tk.Button(self.tool_frame, text="Next", command=self.load_next_iteration)
        self.next_button.pack()

        
        tk.Label(self.tool_frame, text="Opzioni celle col-rows").pack()
        # Opzioni di impostazione della griglia
        self.width_entry = tk.Entry(self.tool_frame)
        self.width_entry.insert(0, self.width)
        self.width_entry.pack()
        self.height_entry = tk.Entry(self.tool_frame)
        self.height_entry.insert(0, self.height)
        self.height_entry.pack()
        tk.Button(self.tool_frame, text="Crea Griglia", command=self.create_grid).pack()
        tk.Button(self.tool_frame, text="Random", command=self.place_random_elements).pack()

        tk.Label(self.tool_frame, text="Cell pixels").pack()
        self.px_entry = tk.Entry(self.tool_frame)
        self.px_entry.insert(0, self.cell_dim)
        self.px_entry.pack()
        tk.Button(self.tool_frame, text="Set px", command=self.draw_grid).pack()
        tk.Button(self.tool_frame, text="Set step to 10", command=self.faster_steps).pack()
        tk.Button(self.tool_frame, text="Set step to 1/10", command=self.slower_steps).pack()


        # Strumenti di disegno sulla griglia
        tk.Label(self.tool_frame, text="Tools:").pack()
        tk.Button(self.tool_frame, text="Start", command=lambda: self.set_tool(CELL_START)).pack()
        tk.Button(self.tool_frame, text="Goals", command=lambda: self.set_tool(CELL_GOAL)).pack()
        tk.Button(self.tool_frame, text="Muro", command=lambda: self.set_tool(CELL_WALL)).pack()
        tk.Button(self.tool_frame, text="Libero", command=lambda: self.set_tool(CELL_EMPTY)).pack()
        tk.Button(self.tool_frame, text="Percorso", command=lambda: self.set_tool(CELL_PATH)).pack()

       
        self.iterations = []  # Una lista per memorizzare le iterazioni dal file di log
        self.current_iteration_index = -1  # Indice dell'iterazione corrente
        self.step = 1
        self.canvas = None  # Canvas for the grid
        self.create_grid()

    def set_tool(self, tool):
        self.current_tool = tool
    def faster_steps(self):
        self.step = self.step *10
    def slower_steps(self):
        self.step = int(self.step /10)
        if(self.step == 0):
            self.step = 1   
    def create_grid(self):
        try:
            self.width = int(self.width_entry.get())
            self.height = int(self.height_entry.get())
            if self.width > 0 and self.height > 0:
                self.grid = [[CELL_EMPTY for _ in range(self.width)] for _ in range(self.height)]
                self.create_canvas()
                self.draw_grid()
            else:
                print("Le dimensioni devono essere positive!")
        except ValueError:
            print("Inserisci valori validi per larghezza e altezza.")

    def create_canvas(self):
        if self.canvas:
            self.canvas.destroy()
        self.canvas = tk.Canvas(self.root, width=self.width * 50, height=self.height * 50)

        # Gestione del click sulla griglia
        self.canvas.bind("<B1-Motion>", self.on_click)
        self.canvas.bind("<Button-1>", self.on_click)
        self.canvas.bind("<Double-Button-1>", self.on_double_click)
        self.canvas.pack()


    def resetBoard(self):
        self.grid = [[CELL_EMPTY for _ in range(self.width)] for _ in range(self.height)]
        self.draw_grid()

    def on_click(self, event):
        if self.grid:
            x, y = event.x // self.cell_dim, event.y // self.cell_dim
            if 0 <= x < self.width and 0 <= y < self.height:
                # if self.grid[y][x] == self.current_tool:
                #     self.grid[y][x] = CELL_EMPTY  # Libera la cella se già colorata
                # else:
                    self.grid[y][x] = self.current_tool
            self.draw_grid()

    def on_double_click(self, event):
        if self.grid:
            x, y = event.x // self.cell_dim, event.y // self.cell_dim
            if 0 <= x < self.width and 0 <= y < self.height:
                self.grid[y][x] = CELL_EMPTY
                self.draw_grid()

    def save_maze(self):
        if self.grid:
            # Ask the user for the file path and name
            file_path = filedialog.asksaveasfilename(defaultextension=".pl", filetypes=[("Prolog Files",    "*.pl")])

            if file_path:
                with open(file_path, "w") as f:
                    f.write(f"num_righe({self.height}).\n")
                    f.write(f"num_colonne({self.width}).\n")
                    for y in range(self.height):
                        for x in range(self.width):
                            cell_type = self.grid[x][y]
                            if cell_type == CELL_START:
                                f.write(f"iniziale(pos({x+1},{y +1})).\n")
                            elif cell_type in [CELL_GOAL,   CELL_PATH_COMPLETED]:
                                f.write(f"finale(pos({x+1},{y+1})). \n")
                            elif cell_type == CELL_WALL:
                                f.write(f"occupata(pos({x+1},{y+1})).\n")
    def draw_grid(self):
        if self.grid and self.canvas:
            self.cell_dim = int(self.px_entry.get())
            self.canvas.delete("all")
            print( self.cell_dim)
            for y in range(self.height):
                for x in range(self.width):
                    cell_type = self.grid[y][x]
                    if cell_type == CELL_WALL:
                        color = "black"
                    elif cell_type == CELL_GOAL:
                        color = "red"
                    elif cell_type == CELL_START:
                        color = "blue"
                    elif cell_type == CELL_PATH:
                        color = "green"
                    elif cell_type == CELL_PATH_COMPLETED:
                        color = "purple"
                    else:
                        color = "white"
                    self.canvas.create_rectangle(x * self.cell_dim, y * self.cell_dim, (x + 1) * self.cell_dim, (y + 1) * self.cell_dim, fill=color)

    def place_random_elements(self):
        if self.grid:
            # self.grid viene rinizializzato con celle vuote
            self.grid = [[CELL_EMPTY for _ in range(self.width)] for _ in range(self.height)]
            empty_cells = [] 
            # Inizia popolando casualmente almeno il 50% delle celle con muri
            for y in range(self.height):
                for x in range(self.width):
                    rand_value = random.random()
                    if rand_value > 0.9:
                        self.grid[y][x] = CELL_WALL
                    else:
                        empty_cells.append((x, y))

            # Scegli una posizione iniziale casuale tra le celle vuote
            if empty_cells:
                start_x, start_y = random.choice(empty_cells)
                self.grid[start_y][start_x] = CELL_START
                empty_cells.remove((start_x, start_y))

            # Scegli due posizioni finali tra le celle rimaste libere
            for _ in range(2):
                if empty_cells:
                    goal_x, goal_y = random.choice(empty_cells)
                    self.grid[goal_y][goal_x] = CELL_GOAL
                    empty_cells.remove((goal_x, goal_y))
            self.draw_grid()
    def load_maze_from_file(self):
            # Apre una finestra di dialogo per la selezione del file
        filename = filedialog.askopenfilename(filetypes=[("File Mappa", "*.pl")])

        if not filename:
            # L'utente ha annullato la selezione del file
            return

        try:
            with open(filename, "r") as f:
                content = f.readlines()

            grid = None  # Inizializziamo grid a None
            width = 0
            height = 0

            # Espressioni regolari per estrarre le informazioni di posizione dal file
            row_col_pattern = re.compile(r'(\d+)')
            position_pattern = re.compile(r'pos\((\d+),(\d+)\)')

            for line in content:
                line = line.strip()
                if line.startswith("num_righe"):
                    match = row_col_pattern.findall(line)
                    if match:
                        height = int(match[0])
                elif line.startswith("num_colonne"):
                    match = row_col_pattern.findall(line)
                    if match:
                        width = int(match[0])
                        # Inizializziamo grid con le dimensioni corrette
                        grid = [[CELL_EMPTY for _ in range(width)] for _ in range(height)]
                elif line.startswith("iniziale"):
                    match = position_pattern.findall(line)
                    if match and grid:
                        start_x, start_y = map(int, match[0])
                        grid[start_x - 1][start_y - 1] = CELL_START
                elif line.startswith("occupata"):
                    match = position_pattern.findall(line)
                    if match and grid:
                        y, x = map(int, match[0])
                        if 0 <= y - 1 < height and 0 <= x - 1 < width:
                            grid[y - 1][x - 1] = CELL_WALL
                elif line.startswith("finale"):
                    match = position_pattern.findall(line)
                    if match and grid:
                        goal_y, goal_x = map(int, match[0])
                        if 0 <= goal_y - 1 < height and 0 <= goal_x - 1 < width:
                            grid[goal_y - 1][goal_x - 1] = CELL_GOAL
            self.grid = grid
            self.width = width
            self.height = height
            self.create_canvas()
            self.draw_grid()
            return grid, width, height
        except FileNotFoundError:
            print(f"File '{filename}' non trovato.")
            return None, 0, 0
        except Exception as e:
            print(f"Errore durante la creazione della mappa da file: {str(e)}")
            return None, 0, 0
        
    def load_solution_from_file(self):
        # Open a file dialog for selecting the solution file
        filename = filedialog.askopenfilename(filetypes=[("Solution File", "*.txt")])

        if not filename:
            # The user canceled the file selection
            return

        try:
            with open(filename, "r") as f:
                content = f.read().strip()
                directions = re.findall(r'\b(giu|su|dx|sx)\b', content)

                if not directions:
                    print("No valid directions found in the file.")
                    return
                # remove from the grid the previous path
                for y in range(self.height):
                    for x in range(self.width):
                        if self.grid[y][x] == CELL_PATH :
                            self.grid[y][x] = CELL_EMPTY
                        if self.grid[y][x] == CELL_PATH_COMPLETED:
                            self.grid[y][x] = CELL_GOAL
                        
                # Find the starting cell (CELLA INIZIALE)
                start_x, start_y = None, None
                for y in range(self.height):
                    for x in range(self.width):
                        if self.grid[y][x] == CELL_START:
                            start_x, start_y = x, y
                            break
                    if start_x is not None:
                        break

                if start_x is None:
                    print("Starting cell (CELLA INIZIALE) not found.")
                    return

                # Apply the directions to build the path
                for direction in directions:
                    if direction == "giu":
                        start_y += 1
                    elif direction == "su":
                        start_y -= 1
                    elif direction == "dx":
                        start_x += 1
                    elif direction == "sx":
                        start_x -= 1

                    # Check if the new position is within the grid
                    if 0 <= start_x < self.width and 0 <= start_y < self.height:
                        if(self.grid[start_y][start_x] == CELL_GOAL and direction == directions[-1]):
                            self.grid[start_y][start_x] = CELL_PATH_COMPLETED
                        else:
                            self.grid[start_y][start_x] = CELL_PATH
                      
                print(self.grid[start_y][start_x])
                # Redraw the grid with the updated path
                self.draw_grid()

        except FileNotFoundError:
            print(f"File '{filename}' not found.")
        except Exception as e:
            print(f"Error while loading solution from file: {str(e)}")

    def load_log_file(self):
           # Open a file dialog for selecting the solution file
        filename = filedialog.askopenfilename(filetypes=[("Solution File", "*.txt")])

        if not filename:
            # The user canceled the file selection
            return

        try:
            with open(filename, "r") as f:
                content = f.read()

                # Split the content into individual iterations
                iterations = content.strip().split("New iteration...\n")

                # Parse each iteration to extract cell positions
                self.iterations = []
                for iteration in iterations:
                    positions = re.findall(r'pos\((\d+),(\d+)\)', iteration)
                    positions: list[tuple[int, int]] = [(int(x)-1, int(y)-1) for x, y in positions]
                    self.iterations.append(positions)

                # Initialize current iteration to the first one
                self.current_iteration_index = 0
                print(self.iterations)
                # Load the first iteration into the grid
                self.load_iteration(self.current_iteration_index)

        except FileNotFoundError:
            print(f"File '{filename}' not found.")
        except Exception as e:
            print(f"Error while loading solution from file: {str(e)}")
            
    def load_iteration(self, iteration_index):
        if 0 <= iteration_index < len(self.iterations):
            iteration = self.iterations[iteration_index]
            # Resetta la griglia alla griglia vuota
            self.resetBoard()
            # Colora le celle visitate in grigio
            for x, y in iteration:
                self.grid[x][y] = CELL_PATH
            self.draw_grid()
    def load_prev_iteration(self):
        if self.iterations:
            self.current_iteration_index = max(0, self.current_iteration_index - self.step)
            self.load_iteration(self.current_iteration_index)

    def load_next_iteration(self):
        if self.iterations:
            self.current_iteration_index = min(len(self.iterations) - 1, self.current_iteration_index + self.step)
            self.load_iteration(self.current_iteration_index)
if __name__ == "__main__":
    root = tk.Tk()
    root.title("Maze Editor")

    editor = MazeEditor(root)
   
    root.mainloop()
