import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class Main {
    private static Automat automat;

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        while (true) {
            try {
                System.out.println("\n1. Afiseaza elementelor unui AF");
                System.out.println("2. Verifica daca o secventa este acceptata de un AFD");
                System.out.println("3. Vezi cel mai lung prefix dintr-o secventa acceptata de un AFD");
                System.out.println("4. Iesire din meniu");
                System.out.print("Comanda : ");
                int cmd = Integer.parseInt(scanner.next());
                switch (cmd) {
                    case 1:
                    {
                        System.out.println("1. Din fisier");
                        System.out.println("2. De la tastatura");
                        System.out.print("Comanda : ");
                        cmd = Integer.parseInt(scanner.next());
                        if (cmd == 1) {
                            System.out.print("Nume fisier : ");
                            String f = "fisiere/" + scanner.next() + ".txt";
                            automat = new Automat(f);
                            vezi_meniu_multimi();
                        }
                        else {
                            String stareInitiala;
                            List<String> stariFinale = new ArrayList<>();
                            List<Tranzitie> tranzitii = new ArrayList<>();
                            String line = "";
                            System.out.print("Stare initiala : ");
                            stareInitiala = scanner.next();
                            System.out.println("Introduceti tranzitiile sub forma <stare1> <intrare> <stare2>");
                            scanner.nextLine();
                            while (!(line = scanner.nextLine()).isEmpty()) {
                                String[] fields = line.split(" ");
                                tranzitii.add(new Tranzitie(fields[0], fields[1], fields[2]));
                            }
                            System.out.print("Stari finale (separate prin virgula) : ");
                            line = scanner.next();
                            stariFinale.addAll(Arrays.asList(line.split(" ")));
                            automat = new Automat(stareInitiala, tranzitii, stariFinale);
                            vezi_meniu_multimi();
                        }
                        break;
                    }

                    case 2:
                    {
                        if (automat == null) {
                            System.out.println("Mergeti la comanda nr 1 pentru a crea un automat!");
                            break;
                        }
                        System.out.print("Secventa : ");
                        String secventa = scanner.next();
                        if (automat.valida(secventa))
                            System.out.println("Secventa este valida!");
                        else
                            System.out.println("Secventa nu este valida!");
                        break;
                    }

                    case 3:
                    {
                        System.out.print("Secventa : ");
                        String secventa = scanner.next();
                        String prefix = automat.celMaiLungPrefix(secventa);
                        if (prefix.equals(""))
                            System.out.println("Niciun prefix al acestei secvente nu este valid!");
                        else
                            System.out.println("Cel mai lung prefix valid este : " + prefix);
                        break;
                    }
                    case 4:
                        return;
                }

            }
            catch (NumberFormatException ex) {
                System.out.println("Optiune invalida!");
            }
        }
    }


    public static void vezi_meniu_multimi() {
        int cmd;
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("\n1. Alfabetul starilor");
            System.out.println("2. Alfabetul intrarilor");
            System.out.println("3. Tranzitii");
            System.out.println("4. Starea initiala");
            System.out.println("5. Stari finale");
            System.out.println("6. Intoarcere la meniu");
            System.out.print("Optiune : ");
            cmd = Integer.parseInt(scanner.next());
            switch (cmd) {
                case 1: {
                    automat.afiseazaStari();
                    break;
                }
                case 2: {
                    automat.afiseazaIntrari();
                    break;
                }
                case 3: {
                    automat.afiseazaTranzitii();
                    break;
                }
                case 4: {
                    automat.afiseazaStareInitiala();
                    break;
                }
                case 5: {
                    automat.afiseazaStariFinale();
                    break;
                }
                case 6:
                    return;
                default: {
                    System.out.println("Optiune invalida!\n");
                }
            }
        }
    }
}