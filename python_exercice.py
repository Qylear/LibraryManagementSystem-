class Book:
    def __init__(self, title: str, author: str):
        self.title = title
        self.author = author
        self.is_available = True  

    def __str__(self):
        return f"'{self.title}' par {self.author} - {'Disponible' if self.is_available else 'Indisponible'}"


class Library:
    def __init__(self):
        self.books = [] 

    def add_book(self, title: str, author: str):
        book = Book(title, author)
        self.books.append(book)

    def list_books(self):
        return [str(book) for book in self.books]

    def lend_book(self, book_title: str, student: 'Student') -> bool:
        if any(book.title == book_title and book.is_available for book in self.books):
            for book in self.books:
                if book.title == book_title and book.is_available:
                    book.is_available = False
                    return True
        return False

    def accept_return(self, book_title: str, student: 'Student'):
        for book in self.books:
            if book.title == book_title:
                book.is_available = True
                return
        print(f"Erreur : Le livre '{book_title}' n'existe pas dans la bibliothèque.")

    def search_books(self, query: str) -> list:
        result = []
        for book in self.books:
            if query.lower() in book.title.lower() or query.lower() in book.author.lower():
                result.append(str(book))
        return result

    def save_books(self, file_path: str):
        with open(file_path, 'w') as file:
            for book in self.books:
                file.write(f"{book.title},{book.author}\n")

    def load_books(self, file_path: str):
        try:
            with open(file_path, 'r') as file:
                for line in file:
                    title, author = line.strip().split(',')
                    self.add_book(title, author)
        except FileNotFoundError:
            print(f"Erreur : Le fichier {file_path} est introuvable.")


class Student:
    def __init__(self, name: str):
        self.name = name
        self.borrowed_books = [] 

    def borrow_book(self, book_title: str, library: Library):
        # Limite l'emprunt à 3 livres
        if len(self.borrowed_books) >= 3:
            print(f"{self.name} ne peut pas emprunter plus de 3 livres.")
            return

        if library.lend_book(book_title, self):
            self.borrowed_books.append(book_title)
            print(f"{self.name} a emprunté '{book_title}'.")

    def return_book(self, book_title: str, library: Library):
        if book_title in self.borrowed_books:
            library.accept_return(book_title, self)
            self.borrowed_books.remove(book_title)
            print(f"{self.name} a retourné '{book_title}'.")
        else:
            print(f"{self.name} n'a pas emprunté ce livre.")


def run_library_system():
    library = Library()
    while True:
        print("\n Menu:")
        print("1. Voir tous les livres")
        print("2. Rechercher un livre")
        print("3. Ajouter un nouveau livre")
        print("4. Emprunter un livre")
        print("5. Retourner un livre")
        print("6. Quitter")
        choice = input("Choisissez une option : ")

        if choice == "1":
            print("\nListe des livres :")
            print("\n".join(library.list_books()))
        elif choice == "2":
            query = input("Entrez un titre ou un auteur à rechercher : ")
            results = library.search_books(query)
            print("\nRésultats de la recherche :")
            print("\n".join(results) if results else "Aucun livre trouvé.")
        elif choice == "3":
            title = input("Entrez le titre du livre : ")
            author = input("Entrez l'auteur du livre : ")
            library.add_book(title, author)
            print(f"Le livre '{title}' a été ajouté à la bibliothèque.")
        elif choice == "4":
            student_name = input("Entrez le nom de l'étudiant : ")
            student = Student(student_name)
            book_title = input("Entrez le titre du livre à emprunter : ")
            student.borrow_book(book_title, library)
        elif choice == "5":
            student_name = input("Entrez le nom de l'étudiant : ")
            student = Student(student_name)
            book_title = input("Entrez le titre du livre à retourner : ")
            student.return_book(book_title, library)
        elif choice == "6":
            print("Au revoir!")
            break
        else:
            print("Option invalide. Essayez à nouveau.")



if __name__ == "__main__":
    run_library_system()
