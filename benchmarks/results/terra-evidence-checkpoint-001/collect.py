#!/usr/bin/env python3
"""Collect a reproducible, scope-aware summary from retained trial records."""
import hashlib,json,pathlib
root=pathlib.Path(__file__).resolve().parents[3];base=root/'benchmarks/results';summary=[];inputs={}
def load(path):
 p=base/path;b=p.read_bytes();inputs[str(path)]=hashlib.sha256(b).hexdigest();return json.loads(b)
for n in (1,2,3):
 s=load(pathlib.Path(f'terra-renderer-energy-audited-001/trial-00{n}.json'));audit=load(pathlib.Path(f'terra-renderer-energy-audited-001/audit-full-00{n}.json'));assert s['status']==audit['status']=='passed';t=s['codec_timing'];assert t['pages']==audit['pages'];assert s['measurement_context_before']==s['measurement_context_after']
 codecs={name:{'encoded_bytes':v['encoded_bytes_total'],'compress_wall_ns_median':v['compress']['wall_ns_median'],'compress_cpu_ns_median':v['compress']['cpu_ns_median'],'compress_package_uj_median':v['compress']['package_uj_per_page_median'],'decompress_wall_ns_median':v['decompress']['wall_ns_median'],'decompress_package_uj_median':v['decompress']['package_uj_per_page_median']} for name,v in t['metrics'].items()}
 summary.append({'trial':n,'pages':t['pages'],'failed_or_nonresident_attempts':s['failures'],'codecs':codecs,'parent_vs_lz4':t['paired_percent']['ghy-combined-avx2'],'sampling_vs_parent':t['candidate_vs_parent_percent'],'parent_vs_userspace_zstd':t['vs_zstd_percent']['ghy-combined-avx2']})
for path in ('terra-combined-sampling-energy-001/audit.json','terra-zerotwo-energy-001/audit.json','terra-simd-device-path-001/corrected-status.json'):
 x=load(pathlib.Path(path));assert x['status'].startswith('passed')
print(json.dumps({'status':'passed','scope':'Reproducible evidence aggregation; per-page warm userspace measurement, not native ZRAM, workload frequency or acceptance outcome','inputs_sha256':inputs,'renderer_trials':summary,'unresolved':['No representative native ZRAM comparison with GZRAM and current stock zstd','No verified hard-hang recovery or alternate boot selection','No native SIMD state cost, application responsiveness or whole-laptop energy measurement','No demonstrated repeatable 10 percent real-world improvement']},indent=2))
