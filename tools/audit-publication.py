#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Best-effort audit of every reachable blob; never print matched secret values."""
import json,re,subprocess,sys
patterns={
 'private-key':r'-----BEGIN (?:OPENSSH |RSA |EC |DSA )?PRIVATE KEY-----',
 'github-token':r'\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,})\b',
 'aws-access-key':r'\b(?:AKIA|ASIA)[A-Z0-9]{16}\b',
 'assigned-credential':r'(?i)\b(?:password|passwd|secret|api_key|access_token)\s*[=:]\s*[\x22\x27][^\x22\x27\n]{4,}[\x22\x27]',
 'private-ipv4':r'\b(?:192\.168\.\d{1,3}\.\d{1,3}|10\.\d{1,3}\.\d{1,3}\.\d{1,3})\b',
 'uuid-value':r'(?i)\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b',
}
findings=[];count=0
objects=subprocess.check_output(['git','rev-list','--objects','--all'],text=True).splitlines()
for line in objects:
 fields=line.split(' ',1)
 if len(fields)!=2:continue
 oid,path=fields
 if subprocess.check_output(['git','cat-file','-t',oid],text=True).strip()!='blob':continue
 count+=1;data=subprocess.check_output(['git','cat-file','blob',oid]).decode(errors='replace')
 for kind,pattern in patterns.items():
  for match in re.finditer(pattern,data):findings.append({'kind':kind,'path':path,'blob':oid,'line':data[:match.start()].count('\n')+1})
 if path.endswith(('.pem','.key','.p12','.pfx','.zip','.tar','.tar.gz','.data')):findings.append({'kind':'review-sensitive-file','path':path,'blob':oid})
print(json.dumps({'scope':'all reachable historical blobs','blob_count':count,'findings':findings},indent=2))
sys.exit(bool(findings))
