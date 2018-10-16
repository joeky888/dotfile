#!/bin/env python3
# -*- coding: utf-8 -*-

import subprocess, sys, time, os, datetime, argparse, codecs, json

parser = argparse.ArgumentParser()
parser.add_argument("-t", "--timeout", help="Set timeout (default: 1.5)", dest="timeout", default="1.5")
parser.add_argument("-u", "--url", help="Set URL (default: http://localhost:8080/CI/DataController/v1/slu)", dest="url", default="http://localhost:8080/CI/DataController/v1/slu")
parser.add_argument("-n", "--number", help="Set numbers of attacks (default: 100)", dest="total_attacks", default="100")
parser.add_argument("-c", "--concurrent", help="Set numbers of concurrent attacks (default: 10)", dest="max_attack_at_once", default="10")
parser.add_argument("-H", "--header", help="Set headers (default: Content-Type: application/json;testing: 123)", dest="header", default="Content-Type: application/json;testing: 123")
parser.add_argument("-v", "--verbose", dest='verbose', action='store_true', default=False)
parser.add_argument("-j", "--jsonfile", help="Set a json file as post body (default: None)", dest='jsonfile', default="")
parser.add_argument("-p", "--body", help="Set headers (default: a long test string about stock...)", dest="body", default='{\
    "dsserialid": "ci stress testing", \
    "debuginfo": { \
        "rt_debug": false, \
        "rt_timestamp": "" \
    }, \
    "timestamp": "1538701914365", \
    "deviceinfo": { \
        "sku": "tw", \
        "modelname": "AI800M", \
        "version": "14.0.0.2", \
        "cusId": "A5C106F4-4EB1-4A15-84B9-58D2D04C2180", \
        "date": "2018-10-05T09:11:54+08:00", \
        "sn": "J8NVKD00044333H" \
    }, \
    "content": [ \
        { \
            "data": { \
                "foregroundSluMode": false, \
                "CrossIntent": true, \
                "Domain": "13329", \
                "correctedSentence": "股票消息", \
                "askBackResponse": false, \
                "input_context": "", \
                "Keyword": "股票", \
                "grammarSentence": "<base.generic.any><$13329_unit.news>", \
                "launch_activity": "", \
                "ask_back_status": "NONE", \
                "IntentionId": "NEWS_KEYWORD", \
                "domain": "com.asus.robotnewsskill", \
                "voconLearnFlag": false, \
                "continuousSpeech": false, \
                "originalSentence": "股票消息", \
                "version": "0,0,22", \
                "output_context": [], \
                "isWebSkill": true, \
                "Phrase": [], \
                "output_text": "", \
                "beliefs": { \
                    "Keyword": { \
                        "concept": "base.generic.any", \
                        "value": "股票" \
                    } \
                } \
            }, \
            "ctype": "asus_ds_slu" \
        } \
    ], \
    "type": "SkillProcess", \
    "serialid": "J8NVKD00044333H1538701914365", \
    "testtype": "RunTrip" }')

args = parser.parse_args()

Error = []
TOTAL_ATTACKS       = int(args.total_attacks)
MAX_ATTACK_AT_ONCE  = int(args.max_attack_at_once)
TIMEOUT             = args.timeout
URL                 = args.url
HEADER              = args.header.split(";")
BODY                = args.body
VERBOSE             = args.verbose
JSONFILE            = args.jsonfile

processes = []

cmd = ['curl', '-s', '--fail', URL, \
    '--connect-timeout', TIMEOUT, \
    '--max-time', TIMEOUT]

for h in HEADER:
    cmd.append("-H")
    cmd.append(h)

if JSONFILE != "":
    cmd.append("-d")
    with codecs.open(JSONFILE,'r',encoding='utf8') as f:
        json.load(f) # Validate json
    with codecs.open(JSONFILE,'r',encoding='utf8') as f:
        jsondata = json.dumps(f.read())
        cmd.append(jsondata)
else:
    json.loads(BODY) # Validate json
    cmd.append("-d")
    cmd.append(BODY)


def progress(current, total):
    sys.stdout.flush()
    sys.stdout.write("\r")
    current += 1.0 # Convert to float

    width = 40
    h = int(current/total*width)
    s = width - h
    output  = "|" + "#"*h + " "*s + "| "
    output += "%.2f" % (current/total*100) + "%  "
    output += str(int(current)) + "/" + str(total)
    sys.stdout.write(output)

failed=0
succ=0
FNULL = open(os.devnull, 'w')

before = datetime.datetime.now()

for idx in range(TOTAL_ATTACKS):
    if VERBOSE:
        processes.append( subprocess.Popen(cmd) )
    else:
        processes.append( subprocess.Popen(cmd, stdout=FNULL, stderr=subprocess.STDOUT) )

    progress(idx, TOTAL_ATTACKS)
    while len(processes) >= MAX_ATTACK_AT_ONCE or (idx == TOTAL_ATTACKS-1 and len(processes) > 0):
        time.sleep(.0001)
        for i, p in enumerate(processes):
            # if p[0].returncode == None, it means that downloading is not finished
            if p.poll() == 0:
                # Succeed
                processes.pop(i)
                succ+=1
            elif p.returncode != None:
                # Failed
                processes.pop(i)
                failed+=1

print("")
print("")
print("Succeed: " + str(succ))
print("Failed:  " + str(failed))
print("Unkown:  " + str(TOTAL_ATTACKS - succ - failed))
print("")
print("Duration:" + str(datetime.datetime.now() - before))
print("")
