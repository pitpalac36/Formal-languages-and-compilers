import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Stack;

public class Main {

    static Hashtable<String,List<List<String>>> dict = new  Hashtable<>();
    static List<String> terminale = new ArrayList<>();
    static List<String> neterminale = new ArrayList<>();
    static int[][] matrice;

    public static void main(String[] args) {
        FileUtils.readDict();
        buildMatrix();
        if (parse(FileUtils.readFip()))
            System.out.println("\nParsare cu succes!");
        else
            System.out.println("\nEroare sintactica!!");
    }

    public static boolean isTerminal(String s){
        return s.equals(s.toUpperCase());
    }

    static void buildMatrix() {
        matrice = new int[neterminale.size()][terminale.size()];
        for (int i = 0; i< neterminale.size(); i++) {
            String neterminal = neterminale.get(i);
            for (int j = 0; j < terminale.size(); j++) {
                String terminal = terminale.get(j);
                matrice[i][j] = search(neterminal, terminal, new ArrayList<>());
            }
        }
    }

    static int search(String neterminal, String terminal, List<String> checked) {
        checked.add(neterminal);
        for (int i = 0; i < dict.get(neterminal).size(); i++) {
            List<String> list = dict.get(neterminal).get(i);
            for (String word : list) {
                if (isTerminal(word))
                    if (word.equals(terminal))
                        return i;
                    else break;
                else
                    if (!checked.contains(word))
                        if (search(word, terminal, checked) != -1)
                            return i;
            }
        }
        return -1;
    }

    static boolean parse(List<Integer> cuvs) {
        Stack<String> stiva = new Stack<>();
        stiva.push("$");
        stiva.push("program");
        String word;
        String popped;
        int ind = 0;
        while (ind < cuvs.size()) {
            word = terminale.get(cuvs.get(ind));
            popped = stiva.pop();
            if (neterminale.contains(popped)) {
                int i = neterminale.indexOf(popped);
                int j = terminale.indexOf(word);
                if (matrice[i][j] == -1)
                    if (matrice[i][terminale.indexOf("EPS")] == -1)
                        return false;
                    else
                        continue;
                System.out.print("\n" + popped + " -> ");
                for (String l : dict.get(popped).get(matrice[i][j]))
                    System.out.print(l + " ");
                System.out.println();
                for (int k = dict.get(popped).get(matrice[i][j]).size() - 1; k >= 0; k--)
                    stiva.push(dict.get(popped).get(matrice[i][j]).get(k));
            } else {
                if (!word.equals(popped))
                    return false;
                ind++;
            }
        }
        return stiva.pop().equals("$");
    }
}