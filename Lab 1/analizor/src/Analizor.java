import java.util.*;

public class Analizor {

    public static String file;
    public static String fipfile = "files/FIP.txt";
    public static String tsfile = "files/TS.txt";

    public static boolean isID(String word) {
        return word.matches("[a-zA-Z]+") && word.length() <= 8;
    }

    public static boolean isConst(String word) {
        return word.matches("[1-9]*|0") || word.matches("\".*\"");
    }

    public static void main(String[] args) throws Exception {

        Map<String, Integer> table = new HashMap<>();
        table.put("ID", 1);
        table.put("CONST", 2);
        table.put("#", 3);
        table.put("include", 4);
        table.put("<", 5);
        table.put(">", 6);
        table.put("stdio.h", 7);
        table.put("int", 8);
        table.put("main", 9);
        table.put("(", 10);
        table.put(")", 11);
        table.put("{", 12);
        table.put("}", 13);
        table.put(",", 14);
        table.put(";", 15);
        table.put("=", 16);
        table.put("scanf", 17);
        table.put("\"%d\"", 18);
        table.put("&", 19);
        table.put("for", 20);
        table.put("/", 21);
        table.put("+", 22);
        table.put("if", 23);
        table.put("%", 24);
        table.put("==", 25);
        table.put("printf", 26);
        table.put("\"", 27);
        table.put("else", 28);
        table.put("return", 29);
        table.put("while", 30);
        table.put("-", 31);
        table.put("\"%lf\"", 32);
        table.put("double", 33);

        Scanner scanner = new Scanner(System.in);
        System.out.print("Fisier : ");
        file = "files/" + scanner.next() + ".txt";

        List<String> words = FileUtils.readFromFile(file);
        List<FIP> fip = new ArrayList<>();
        TS ts = new TS(40);
        boolean added;

        for (String each : words) {
             added = false;
            if (table.containsKey(each)) {
                fip.add(new FIP(table.get(each), -1));
                added = true;
            }
            else {
                int poz;
                poz = ts.find(each);
                if (poz == -1)
                    poz = ts.insert(each);
                if (isID(each)) {
                    fip.add(new FIP(table.get("ID"), ts.get(poz).getCode()));
                    added = true;
                }
                if (isConst(each)) {
                    fip.add(new FIP(table.get("CONST"), ts.get(poz).getCode()));
                    added = true;
                }
            }
            if (!added) {
                throw new Exception("Eroare lexicala : " + each);
            }
        }
        FileUtils.writeToFile(fipfile, (ArrayList) fip);
        FileUtils.writeToFile(tsfile, ts.asArray());
    }
}