{:user {:dependencies [[slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :plugins [[lein-kibit "0.1.2"]
                  [com.jakemccrary/lein-test-refresh "0.15.0"]
                  [venantius/ultra "0.4.1"]
                  [lein-cloverage "1.0.6"]
                  [lein-cljfmt "0.5.3"]
                  [jonase/eastwood "0.2.3"]]
        :repl-options {:prompt (fn [ns] (str "λ " ns " ─➤ "))}}}
