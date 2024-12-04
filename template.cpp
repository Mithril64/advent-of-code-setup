#include <bits/stdc++.h>
using namespace std;

#define FAST_IO ios_base::sync_with_stdio(false); cin.tie(nullptr);

using ll = long long;
using ull = unsigned long long;
using ld = long double;

const ll MOD = 1e9 * 7;
const ll INF = 1e18;

#define all(v) (v).begin(), (v).end()
#define rall(v) (v).rbegin(), (v).rend()
#define pb(vect, val) vect.push_back(val)
#define mp make_pair
#define F first
#define S second

#define FOR(i, a, b) for (size_t i = a; i < b; ++i)
#define REP(i, n) for (size_t i = 0; i < n; ++i)

typedef std::vector<int> vi;
typedef std::vector<vector<int>> vvi;
typedef std::vector<int, int> vii;

int main() {
    FAST_IO;
    string path = "../input.txt"; // Adjust if needed
    ifstream file(path);

    if (!file.is_open()) {
        cerr << "Couldn't open file " << path << endl;
        return 1;
    }

    return 0;
}
