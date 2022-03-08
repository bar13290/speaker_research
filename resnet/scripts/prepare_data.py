import os
import argparse
import pickle

import torch
import torch.nn.functional as F
import kaldi_io

def main():
  parser = argparse.ArgumentParser("Configuration for data preparation")
  parser.add_argument("--feat_scp", type=str, help="Path to the VoxCeleb features generated by the Kaldi scripts")
  parser.add_argument("--save_dir", type=str, help="Directory to save the preprocessed pytorch tensors")
  config = parser.parse_args()

  id2len = {}
  for key,mat in kaldi_io.read_mat_scp(config.feat_scp):
    id2len[key + '.pt'] = len(mat)
    log_mel = torch.FloatTensor(mat)
    torch.save(log_mel, os.path.join(config.save_dir, key + '.pt'))

  with open(os.path.join(config.save_dir, 'lengths.pkl'), 'wb') as f:
    pickle.dump(id2len, f, protocol=4)

if __name__ == '__main__':
  main()
