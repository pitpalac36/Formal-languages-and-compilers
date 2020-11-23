import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Automat {

    private List<String> stari = new ArrayList<>();
    private List<String> intrari = new ArrayList<>();
    private List<Tranzitie> tranzitii = new ArrayList<>();
    private String stareInitiala;
    private List<String> stariFinale = new ArrayList<>();


    public Automat(String fileName) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(fileName));
            boolean isFirstLine = true;
            String line = reader.readLine();
            while (line != null) {
                if (isFirstLine) {  // linia contine starea initiala
                    this.stareInitiala = line;
                    isFirstLine = false;
                }
                else {
                    String[] fields = line.split(" ");
                    if (fields.length > 1) {    // linia contine o tranzitie
                        if (!this.stari.contains(fields[0]))    // adauga stare
                            this.stari.add(fields[0]);
                        if (!this.stari.contains(fields[2]))    // adauga stare
                            this.stari.add(fields[2]);
                        if (!this.intrari.contains(fields[1]))  // adauga intrare
                            this.intrari.add(fields[1]);
                        Tranzitie t = new Tranzitie(fields[0], fields[1], fields[2]);
                        this.tranzitii.add(t);
                    }
                    else {  // linia contine multimea starilor finale
                        fields = line.split(",");
                        this.stariFinale.addAll(Arrays.asList(fields));
                    }
                }
                line = reader.readLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Automat(String stareInitiala, List<Tranzitie> tranzitii, List<String> stariFinale) {
        this.stareInitiala = stareInitiala;
        this.stariFinale = stariFinale;
        this.tranzitii = tranzitii;

        for (Tranzitie each : tranzitii) {
            if (!stari.contains(each.getStare1()))
                stari.add(each.getStare1());
            if (!stari.contains(each.getStare2()))
                stari.add(each.getStare2());
            if (!intrari.contains(each.getIntrare()))
                intrari.add(each.getIntrare());
        }
    }

    public void afiseazaStari() {
        System.out.print("Alfabetul starilor : { ");
        for (String each : this.stari) {
            if (this.stari.indexOf(each) == this.stari.size() - 1)
                System.out.print(" " + each + " }");
            else
                System.out.print(" " + each + ",");
        }
        System.out.println();
    }

    public void afiseazaIntrari() {
        System.out.print("\nAlfabetul intrarilor : {");
        for (String each : this.intrari) {
            if (this.intrari.indexOf(each) == this.intrari.size() - 1)
                System.out.print(each + " }");
            else
                System.out.print(" " + each + ", ");
        }
        System.out.println();
    }

    public void afiseazaTranzitii() {
        System.out.print("\nTranzitii : { ");
        for (Tranzitie each : this.tranzitii) {
            if (this.tranzitii.indexOf(each) == this.tranzitii.size() - 1)
                System.out.print(each.toString() + " }");
            else
                System.out.print(" " + each.toString() + ", ");
        }
        System.out.println();
    }

    public void afiseazaStareInitiala() {
        System.out.println("\nStare initiala : " + this.stareInitiala);
        System.out.println();
    }


    public void afiseazaStariFinale() {
        System.out.print("Stari finale : { ");
        for (String each : this.stariFinale) {
            if (this.stariFinale.indexOf(each) == this.stariFinale.size() - 1)
                System.out.print(" " + each + " }");
            else
                System.out.print(" " + each + ",");
        }
        System.out.println();
    }


    public boolean valida(String secventa) {
        String starePornire = this.stareInitiala;
        String stareSosire = "";
        String urm = "";

        for (int i = 0 ; i < secventa.length(); i++) {
            String one = secventa.substring(i, i + 1);
            urm = "";
            for (Tranzitie t : this.tranzitii)
                if (t.getStare1().equals(starePornire) && t.getIntrare().equals(one)) {
                    urm = t.getStare2();
                    break;
                }
            if (urm.isEmpty())
                return false;

            if (this.stariFinale.contains(urm) && i == secventa.length() - 1) {
                stareSosire = urm;
                break;
            }
            starePornire = stareSosire = urm;
        }
        return this.stariFinale.contains(stareSosire);
    }


    public String celMaiLungPrefix(String secventa) {
        String prefix = "";
        String longest = "";

        for (int i = 0 ; i < secventa.length(); i++) {
            prefix = secventa.substring(0, i + 1);
            if (this.valida(prefix))
                longest = prefix;
        }
        return longest;
    }
}


class Tranzitie {

    private String stare1;
    private String stare2;
    private String intrare;

    public Tranzitie(String stare1, String intrare, String stare2) {
        this.stare1 = stare1;
        this.stare2 = stare2;
        this.intrare = intrare;
    }

    public String getStare1() {
        return stare1;
    }

    public String getStare2() {
        return stare2;
    }

    public String getIntrare() {
        return intrare;
    }

    @Override
    public String toString() {
        return this.stare1 + " " + this.intrare + " " + this.stare2;
    }
}