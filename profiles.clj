{:user {:dependencies [[slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.1.2"]
                  [com.jakemccrary/lein-test-refresh "0.11.0"]
                  [venantius/ultra "0.3.4"]
                  [lein-cloverage "1.0.6"]
                  [lein-cljfmt "0.3.0"]
                  [jonase/eastwood "0.2.1"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}
        :ultra {:color-scheme :solarized_dark}}}
