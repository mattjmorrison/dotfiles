{:user {:dependencies [[slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.0.8"]
                  [com.jakemccrary/lein-test-refresh "0.6.0"]
                  [venantius/ultra "0.2.0"]
                  [lein-cloverage "1.0.2"]
                  [lein-cljfmt "0.1.7"]
                  [jonase/eastwood "0.2.1"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}
        :ultra {:color-scheme :solarized_dark}}}
