import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;

public class FileUtils {

    public static void readDict() {
        Path in  = Paths.get("grammar.txt");
        try {
            List<String> lines = Files.readAllLines(in);
            int i = 0;
            while (i<lines.size()) {
                String line = lines.get(i);
                String [] parts = line.split(" ");
                String word = parts[0];
                Main.dict.put(word,new ArrayList<>());
                if(!Main.neterminale.contains(word))
                    Main.neterminale.add(word);
                i++;
                while (!lines.get(i).contains(";") || lines.get(i).contains("';'")) {
                    if (lines.get(i).equals("")) {
                        ArrayList<String> l = new ArrayList<>();
                        l.add("EPS");
                        Main.dict.get(word).add(l);
                        if (!Main.terminale.contains("EPS")) {
                            Main.terminale.add("EPS");
                        }
                    }
                    else {
                        List<String> words = new ArrayList<>();
                        for (String s : lines.get(i).split(" ")) {
                            if (s.equals("';'"))
                                s=";";
                            words.add(s);
                            if (Main.isTerminal(s)) {
                                if (!Main.terminale.contains(s))
                                    Main.terminale.add(s);
                            }
                        }
                        Main.dict.get(word).add(words);
                    }
                    i++;
                }
                i++;
                while (i<lines.size() && lines.get(i).equals(""))
                    i++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static  List<Integer> readFip(){
        List<Integer> list = new ArrayList<>();
        Dictionary<Integer,Integer> trans = new Hashtable<>();
        try {
            List<String> lines = Files.readAllLines(Paths.get("keywords.txt"));
            for (String line : lines) {
                String word = line.split(" ")[0].toUpperCase().trim();
                int nr = Integer.parseInt(line.split(" ")[1].trim());
                trans.put(nr, Main.terminale.indexOf(word));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            List<String> lines = Files.readAllLines(Paths.get("program.txt"));
            for (String line : lines){
                list.add(trans.get(Integer.parseInt(line.split(" ")[0].trim())));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }
}
