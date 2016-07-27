import numpy
import sys
import json
import math


class StreamMoments(object):
    from sys import float_info

    def __init__(self, count=0, min=float_info.max,
                 max=-float_info.max, m1=0.0, m2=0.0):
        self.count = count
        self.min = min
        self.max = max
        self.m1 = m1
        self.m2 = m2

    def __lshift__(self, sample):
        self.max = max(self.max, sample)
        self.min = min(self.min, sample)
        dev = sample - self.m1
        self.m1 = self.m1 + (dev / (count + 1))
        self.m2 = self.m2 + (dev * dev) * count / (count + 1)
        self.count += 1
        return self

    def mean(self):
        return self.m1

    def variance(self):
        return self.m2 / self.count

    def stddev(self):
        return math.sqrt(self.variance)


def sb_cossim(indices, v, normv):
    dotuv = sum([v[i] for i in indices])
    normu = math.sqrt(len(indices))
    sim = dotuv / (normu * normv)
    return min(1.0, max(0.0, sim))


class SOM(object):
    def __init__(self, xdim=0, ydim=0, fdim=0,
                 entries=[], norms=[], mqsink=None):
        self.xdim = xdim
        self.ydim = ydim
        self.fdim = fdim
        self.entries = entries
        self.norms = norms
        self.mqsink = mqsink

    def sparseBooleanBestWithSimilarity(self, features, indices):
        """Returns the best similarity result.

        This code assumes a sparse boolean vector for the testing
        example.  `features` is the maximum number of elements and
        `indices` is a unique array of elements that are set to 1 in the
        sparse example vector

        """

        best = (0, 0.0)
        for i in range(len(self.entries)):
            sim = sb_cossim(indices, self.entries[i], self.norms[i])
            if sim > best[1]:
                best = (i, sim)
        return best

    def sparseBooleanBestSimilarity(self, features, indices):
        return self.sparseBooleanBestWithSimilarity(features, indices)[1]


def fromJSON(file, m=sys.modules[__name__]):
    import sys
    with open(file) as f:
        struct = json.load(f)
        keys = [struct["moments"][key]
                for key in ["count", "min", "max", "m1", "m2"]]
        moments = m.StreamMoments(*keys)
        fdim = struct["fdim"]
        ydim = struct["ydim"]
        xdim = struct["xdim"]
        entries = [e for e in struct["entries"]]
        norms = [numpy.linalg.norm(e) for e in entries]
        return m.SOM(xdim, ydim, fdim, entries, norms, moments)
