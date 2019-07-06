docker run -it --name teamcity-server-instance  -v C:\Users\pjeloudovski\dockerfiles\teamcity\data:/data/teamcity_server/datadir -v C:\Users\pjeloudovski\dockerfiles\teamcity\logs:/opt/teamcity/logs -p 8111:8111 jetbrains/teamcity-server
docker run -it -e SERVER_URL="http://localhost:8111"  \ 
    -v C:\Users\pjeloudovski\dockerfiles\teamcity\agent:/data/teamcity_agent/conf  \      
    jetbrains/teamcity-agent
